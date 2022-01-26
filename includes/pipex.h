/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   pipex.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/12/20 10:22:57 by yjimpei           #+#    #+#             */
/*   Updated: 2022/01/21 18:03:04 by yjimpei          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PIPEX_H
# define PIPEX_H

# include <unistd.h>
# include <sys/types.h>
# include <sys/wait.h>
# include <fcntl.h>
# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>
# include <string.h>
# include <errno.h>
# include "libft.h"

# define TRUE (1)
# define FALSE (0)
typedef int	t_bool;
# define READ (0)
# define WRITE (1)

typedef struct s_arginfo
{
	char	**exargv1;
	char	**exargv2;
	char	*out_flnm;
	char	*in_flnm;
	char	**env_lst;
	int		path_cnt;
	int		in_fd;
	int		out_fd;
	char	*cmd1;
	char	*cmd2;
}			t_arginfo;

void	init_arg_info(char **argv, t_arginfo *info, char **envp);
void	all_free(t_arginfo *info);
void	free_dbl_char(char **pptr);
void	error_exit(char *msg, t_arginfo *info);
void	wait_child(t_arginfo *info);
void	prepare_fork(int fd, int *pipe_fd, int dup_fd, t_arginfo *info);

void	set_env_path(char **envp, t_arginfo *info);
char	*trim_cmd_name(char *pathname);
#endif