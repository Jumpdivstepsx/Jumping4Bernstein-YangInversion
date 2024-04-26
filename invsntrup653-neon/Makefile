CC=    gcc
LD=    gcc

PROJ   ?= crypto_core/jump
REF    ?= crypto_core/div

SRC_DIR  = $(PROJ)
REF_DIR  = $(REF)

SRC_EXT_DIR =

POLY = polymul

POLY_DIR   = ./crypto_core/jump/polymul
MATRIX_DIR = ./crypto_core/jump/matrixmul
DIV_DIR    = ./crypto_core/jump/divstepsx
JUMP_DIR   = ./crypto_core/jump/jump
CYCLE_DIR = ../cycles
COMM_DIR  = ../fake-supercop
TEST_DIR  = ./tests

#CFLAGS   := -O3 $(CFLAGS) -std=c11 -Wall -Wextra -fno-omit-frame-pointer -D'CRYPTO_NAMESPACE(x)=x' #-pg -g -fsanitize=address
CFLAGS := $(CFLAGS) -Wno-conversion -O3 -I$(CYCLE_DIR)
INCPATH  := -I/usr/local/include -I/opt/local/include -I/usr/include -I$(SRC_DIR) -I$(COMM_DIR) -I$(TEST_DIR) -I$(REF_DIR)
LDFLAGS  := $(LDFLAGS) #-fsanitize=address
LIBPATH  = -L/usr/local/lib -L/usr/lib
# LIBS     = -lcrypto #-lasan

ifeq ($(PROJ),crypto_core/jump)
SRC_EXT_DIRS  += $(POLY_DIR)   $(JUMP_DIR)   $(DIV_DIR)   $(MATRIX_DIR)
INCPATH      += -I$(POLY_DIR)  -I$(DIV_DIR)  -I$(JUMP_DIR)   -I$(MATRIX_DIR)
endif

ifdef ASAN
CFLAGS  += -fsanitize=address -fno-sanitize-recover=all
LDFLAGS += -fsanitize=address -fno-sanitize-recover=all
endif

ifeq ($(CC),clang)
CFLAGS    += -flax-vector-conversions -D_BLAS_NEON_
else
CFLAGS    += -flax-vector-conversions -D_BLAS_NEON_
endif

SRCS    :=  $(foreach dir, $(SRC_EXT_DIRS), $(wildcard  $(dir)/*.c))
SRCS    +=  $(wildcard $(SRC_DIR)/*.c)  $(wildcard $(SRC_DIR)/*.S) $(wildcard $(REF_DIR)/*.c)
ifeq ($(PROJ),crypto_core/jump)
	SRCS    +=  $(wildcard $(POLY_DIR)/*.S)
endif

SRCS_O         :=  $(SRCS:.c=.o)
SRCS_O         :=  $(SRCS_O:.S=.o)
SRCS_O_NOTDIR  :=  $(notdir $(SRCS_O))

OBJS = $(SRCS_O_NOTDIR)

OS := $(shell uname -s)
ifeq  ($(OS), Darwin)
CFLAGS    +=  -D_MAC_
OBJS      +=  m1cycles.o
endif

.INTERMEDIATE:  $(OBJS)


.PHONY: all tests #clean


all:

polymul: polymul_test.o  $(OBJS)
	$(LD) $(LDFLAGS) $(LIBPATH) -o test.exe $^ $(LIBS)
	./test.exe

recip: recip_test.o  $(OBJS)
	$(LD) $(LDFLAGS) $(LIBPATH) -o recip.exe $^ $(LIBS)
	./recip.exe

%.o: $(CYCLE_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(REF_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(SRC_DIR)/$(POLY)/%.S
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(COMM_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

define GEN_O
%.o: $(1)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $$<
endef
$(foreach dir, $(SRC_EXT_DIRS), $(eval $(call GEN_O,$(dir))))

clang-format:
	clang-format -i crypto_core/jump/**/*.c
	clang-format -i crypto_core/jump/**/*.h
	clang-format -i tests/*.c
	clang-format -i tests/*.h

clean:
	-rm *.o *.exe *-test *-benchmark massif.out.* *-time ttt.txt