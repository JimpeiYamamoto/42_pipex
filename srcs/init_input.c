/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init_input.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/12/27 22:10:36 by yjimpei           #+#    #+#             */
/*   Updated: 2022/01/21 21:50:28 by yjimpei          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

static char	*path_seach(char **env_lst, char **exargv)
{
	int		i;
	char	*tmp;
	char	*tmp2;

	i = 0;
	if (env_lst == NULL)
		return (NULL);
	while (env_lst[i] != NULL)
	{
		tmp = ft_strjoin(env_lst[i], "/");
		tmp2 = ft_strjoin(tmp, exargv[0]);
		if (access(tmp2, X_OK) == 0)
		{
			free(tmp);
			return (tmp2);
		}
		free(tmp);
		free(tmp2);
		i++;
	}
	return (NULL);
}

static void	put_command_not_found(char *msg)
{
	ft_putstr_fd(msg, STDERR_FILENO);
	ft_putendl_fd(": command not found", STDERR_FILENO);
}

static void	init_cmd1_info(char **argv, t_arginfo *info, char **envp)
{
	char	*tmp;

	info->exargv1 = ft_split(argv[2], ' ');
	if (ft_strchr(argv[2], '/') == NULL)
	{
		if (envp == NULL && info->in_fd != -1)
			put_command_not_found(argv[2]);
		else
		{
			info->cmd1 = path_seach(info->env_lst, info->exargv1);
			if (info->cmd1 == NULL && info->in_fd != -1)
				put_command_not_found(info->exargv1[0]);
		}
		return ;
	}
	if (access(info->exargv1[0], X_OK) == 0)
	{
		info->cmd1 = ft_strdup(info->exargv1[0]);
		tmp = ft_strdup(info->exargv1[0]);
		free(info->exargv1[0]);
		info->exargv1[0] = trim_cmd_name(tmp);
		free(tmp);
	}
	else if (info->in_fd != -1)
		put_command_not_found(info->exargv1[0]);
}

static void	init_cmd2_info(char **argv, t_arginfo *info, char **envp)
{
	char	*tmp;

	info->exargv2 = ft_split(argv[3], ' ');
	if (ft_strchr(argv[3], '/') == NULL)
	{
		if (envp == NULL && info->out_fd != -1)
			put_command_not_found(argv[3]);
		else
		{
			info->cmd2 = path_seach(info->env_lst, info->exargv2);
			if (info->cmd2 == NULL && info->out_fd != -1)
				put_command_not_found(info->exargv2[0]);
		}
		return ;
	}
	if (access(info->exargv2[0], X_OK) == 0)
	{
		info->cmd2 = ft_strdup(info->exargv2[0]);
		tmp = ft_strdup(info->exargv2[0]);
		free(info->exargv2[0]);
		info->exargv2[0] = trim_cmd_name(tmp);
		free(tmp);
	}
	else if (info->out_fd != -1)
		put_command_not_found(info->exargv2[0]);
}

void	init_arg_info(char **argv, t_arginfo *info, char **envp)
{
	info->in_flnm = ft_strdup(argv[1]);
	info->out_flnm = ft_strdup(argv[4]);
	set_env_path(envp, info);
	info->in_fd = open(argv[1], O_RDWR);
	if (info->in_fd == -1)
		perror(argv[1]);
	init_cmd1_info(argv, info, envp);
	info->out_fd = open(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (info->out_fd == -1)
		perror(argv[4]);
	init_cmd2_info(argv, info, envp);
}
