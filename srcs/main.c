/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/12/20 10:22:40 by yjimpei           #+#    #+#             */
/*   Updated: 2022/01/21 21:27:25 by yjimpei          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

void	first_cmd(t_arginfo *info, char **envp)
{
	int	pipe_fd[2];
	int	pid;

	prepare_fork(info->in_fd, pipe_fd, STDIN_FILENO, info);
	pid = fork();
	if (pid == -1)
		error_exit("fork", info);
	if (pid == 0)
	{
		close(pipe_fd[READ]);
		if (dup2(pipe_fd[WRITE], STDOUT_FILENO) == -1)
			error_exit("dup2", info);
		execve(info->cmd1, info->exargv1, envp);
		close(pipe_fd[WRITE]);
		exit(EXIT_FAILURE);
	}
	else
	{
		close(pipe_fd[WRITE]);
		if (dup2(pipe_fd[READ], STDIN_FILENO) == -1)
			error_exit("dup2", info);
		close(info->in_fd);
		close(pipe_fd[READ]);
	}
}

void	second_cmd(t_arginfo *info, char **envp)
{
	int		pipe_fd2[2];
	int		pid;

	prepare_fork(info->out_fd, pipe_fd2, STDOUT_FILENO, info);
	pid = fork();
	if (pid == -1)
		error_exit("fork", info);
	if (pid == 0)
	{
		close(pipe_fd2[READ]);
		if (dup2(info->out_fd, STDOUT_FILENO) == -1)
			error_exit("dup2", info);
		execve(info->cmd2, info->exargv2, envp);
		close(pipe_fd2[WRITE]);
		exit(EXIT_FAILURE);
	}
	else
	{
		close(pipe_fd2[WRITE]);
		wait_child(info);
		wait_child(info);
		close(info->out_fd);
		close(pipe_fd2[READ]);
	}
}

void	init_struct(t_arginfo *info)
{
	info->exargv1 = NULL;
	info->exargv2 = NULL;
	info->out_flnm = NULL;
	info->in_flnm = NULL;
	info->env_lst = NULL;
	info->path_cnt = 0;
	info->cmd1 = NULL;
	info->cmd2 = NULL;
}

int	main(int argc, char **argv, char **envp)
{
	t_arginfo	*info;

	if (argc != 5)
	{
		ft_putendl_fd("Invalid Number of Arguments", STDERR_FILENO);
		exit(EXIT_FAILURE);
	}
	info = malloc(sizeof(t_arginfo));
	if (info == NULL)
	{
		ft_putendl_fd("Error:malloc", STDERR_FILENO);
		exit(EXIT_FAILURE);
	}
	init_struct(info);
	init_arg_info(argv, info, envp);
	first_cmd(info, envp);
	second_cmd(info, envp);
	all_free(info);
	exit(EXIT_SUCCESS);
}
