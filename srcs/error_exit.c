/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   error_exit.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/12/27 22:13:46 by yjimpei           #+#    #+#             */
/*   Updated: 2022/01/21 21:52:55 by yjimpei          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

/*
void	put_all_info(t_arginfo *info)
{
	int	i;
	ft_printf("cmd1=%s\n", info->cmd1);
	ft_printf("***exargv1***\n");
	i = 0;
	while (info->exargv1 != NULL && info->exargv1[i] != NULL)
	{
		ft_printf("%s\n", info->exargv1[i]);
		i++;
	}
	ft_printf("cmd2=%s\n", info->cmd2);
	ft_printf("***exargv2***\n");
	i = 0;
	while (info->exargv2 != NULL && info->exargv2[i] != NULL)
	{
		ft_printf("%s\n", info->exargv2[i]);
		i++;
	}
	ft_printf("***env_lst***\n");
	i = 0;
	while (info->env_lst != NULL && info->env_lst[i] != NULL)
	{
		ft_printf("%s\n", info->env_lst[i]);
		i++;
	}
	ft_printf("infile=%s\noutfile=%s\n", info->in_flnm, info->out_flnm);
}
*/

void	free_dbl_char(char **pptr)
{
	int	i;

	i = 0;
	if (pptr == NULL)
		return ;
	while (pptr[i] != NULL)
	{
		free(pptr[i]);
		i++;
	}
	free(pptr);
}

void	all_free(t_arginfo *info)
{
	free_dbl_char(info->exargv1);
	free_dbl_char(info->exargv2);
	free_dbl_char(info->env_lst);
	free(info->cmd1);
	free(info->cmd2);
	free(info->in_flnm);
	free(info->out_flnm);
	free(info);
}

void	error_exit(char *msg, t_arginfo *info)
{
	perror(msg);
	close(info->out_fd);
	all_free(info);
	exit(EXIT_FAILURE);
}
