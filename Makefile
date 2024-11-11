# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmoussou <mmoussou@student.42angouleme.fr  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/22 07:21:18 by mmoussou          #+#    #+#              #
#    Updated: 2024/11/11 12:58:01 by mmoussou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = test

SRCS = 

SHELL = bash

CC = gcc

LIBFT_DIR = ./libft

LIBFT = $(LIBFT_DIR)/libft.a

LIBFT_INCLUDE = $(LIBFT_DIR)/include

CFLAGS = -Wall -Werror -Wextra -g

INCLUDE = ./include

OBJS = $(SRCS:.c=.o)

define SCRIPT_SRCS
import fileinput
import os
fl=[]
for r, d, f in os.walk('./src'):
 for dn in d:fl.append(os.path.join(r,dn))
 for fn in f:fl.append(os.path.join(r,fn))
for line in fileinput.input("Makefile", inplace=True):print(line if line[:5] != "SRCS " else f'SRCS = {" ".join(fl)}\n', end='')
endef
export SCRIPT_SRCS

all: $(NAME)

CHECK_SRCS:
	@python3 -c "$$SCRIPT_SRCS"

$(LIBFT_DIR):
	@git clone https://github.com/y-syo/libft $(LIBFT_DIR)
	@printf "\x1B[1;34m[  ] cloned libft.\x1B[0m\n"

$(LIBFT): $(LIBFT_DIR)
	@make -sj -C $(LIBFT_DIR)

%.o: %.c
	@printf "\x1B[1;32m[ 󱌣 ]\x1B[0m srcs : compiling : $(CC)\t$@\n"
	@$(CC) $(CFLAGS) -I$(INCLUDE) $< -c -o $@

$(NAME): CHECK_SRCS $(LIBFT) $(OBJS)
	@printf "\x1B[1;32m[ 󱌣 ] srcs: compiled.\x1B[0m\n"
	@printf "\x1B[1;33m[ 󱉟 ]\x1B[0m compiling : $(CC)\t$(NAME)\n"
	@$(CC) $(CFLAGS) $(OBJS) $(LIBFT) -I$(INCLUDE) -I$(LIBFT_INCLUDE) -o $(NAME)
	@printf "\x1B[1;33m[ 󱉟 ] $(NAME) compiled.\x1B[0m\n"

clean:
	@make -s -C $(LIBFT_DIR) clean
	@rm -f $(OBJS)
	@printf "\x1B[1;31m[  ]\x1B[0m deleted objects.\n"

fclean: clean
	@make -s -C $(LIBFT_DIR) fclean
	@rm -f $(NAME)
	@printf "\x1B[1;31m[  ] deleted $(NAME).\x1B[0m\n"

re: fclean all

.PHONY: all clean fclean re CHECK_SRCS
