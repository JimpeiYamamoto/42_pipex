/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex_utils.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/01/10 21:09:18 by yjimpei           #+#    #+#             */
/*   Updated: 2022/01/21 21:49:35 by yjimpei          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

void	wait_child(t_arginfo *info)
{
	int	status;

	wait(&status);
	if (status != 0)
	{
		all_free(info);
		exit(EXIT_FAILURE);
	}
}

void	prepare_fork(int fd, int *pipe_fd, int dup_fd, t_arginfo *info)
{
	if (fd == -1)
	{
		close(info->out_fd);
		all_free(info);
		exit(EXIT_FAILURE);
	}
	if (pipe(pipe_fd) == -1)
		error_exit("pipe", info);
	if (dup2(fd, dup_fd) == -1)
		error_exit("dup2", info);
}

static void	remove_path(t_arginfo *info)
{
	char	*tmp;

	tmp = ft_strdup(info->env_lst[0] + 5);
	free(info->env_lst[0]);
	info->env_lst[0] = ft_strdup(tmp);
	free(tmp);
}

void	set_env_path(char **envp, t_arginfo *info)
{
	int	i;

	i = 0;
	if (envp == NULL)
		return ;
	while (envp[i] != NULL)
	{
		if (ft_strncmp("PATH=", envp[i], 5) == 0)
			break ;
		i++;
	}
	if (envp[i] == NULL)
		return ;
	info->env_lst = ft_split(envp[i], ':');
	remove_path(info);
	i = 0;
	while (info->env_lst[i] != NULL)
		i++;
	info->path_cnt = i;
}

char	*trim_cmd_name(char *pathname)
{
	size_t	len;
	size_t	i;
	size_t	j;
	char	*cmd_name;

	len = ft_strlen(pathname);
	i = 0;
	while (len - i > 0 && pathname[len - i - 1] != '/')
		i++;
	cmd_name = malloc(sizeof(char) * (i + 1));
	j = 0;
	while (i > 0)
	{
		cmd_name[j] = pathname[len - i];
		i--;
		j++;
	}
	return (cmd_name);
}
