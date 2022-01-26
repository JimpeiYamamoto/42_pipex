# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yjimpei <yjimpei@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/23 13:03:51 by yjimpei           #+#    #+#              #
#    Updated: 2022/01/10 21:10:12 by yjimpei          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex
CC = gcc
RM = rm -f
CFLAGS = -Wall -Wextra -Werror
CFLAGS_MEM = -Wall -Wextra -Werror -g -fsanitize=address
INCLUDES = -I./includes -I.
LIBFT = ./lib/libft/libft.a

SRC	=	srcs/main.c \
		srcs/init_input.c \
		srcs/error_exit.c \
		srcs/pipex_utils.c

SRC_DIRS = ${dir ${SRC}}
OBJ_DIR = ./obj
BIN_DIRS = ${addprefix ${OBJ_DIR}/, ${SRC_DIRS}}
OBJS = ${addprefix ${OBJ_DIR}/, ${SRC:.c=.o}}

all:		${NAME}

${NAME}:	${OBJS} ${LIBFT}
	${CC} -g ${CFLAGS} $^ ${INCLUDES} -o $@

${LIBFT}:
	${MAKE} -C ./lib/libft

${OBJ_DIR}/%.o: %.c
	@mkdir -p ${BIN_DIRS}
	${CC} -g ${CFLAGS} ${INCLUDES} -o $@ -c $<

mem:	${OBJS} ${LIBFT}
	${CC} -g ${CFLAGS_MEM} $^ ${INCLUDES} -o ${NAME}

test:
	./testcase/test.sh

clean:
	$(MAKE) clean -C ./lib/libft
	${RM} -r ${OBJ_DIR}

fclean:clean
	${MAKE} fclean -C ./lib/libft
	${RM} ${NAME}

re: fclean all

.PHONY: all clean fclean re mem
