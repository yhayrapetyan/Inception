NAME= inception

all:
	@echo Configuring project


clean:
	@echo clean

fclean: clean
	@echo fclean


re: fclean all

.PHONY: all clean fclean re
	
