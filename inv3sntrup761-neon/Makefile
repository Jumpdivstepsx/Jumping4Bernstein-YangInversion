CC=    gcc
LD=    gcc

PROJ   ?= crypto_core/jump
REF    ?= crypto_core/div

SRC_DIR  = $(PROJ)
REF_DIR  = $(REF)

SRC_EXT_DIR =
POLY = polymul

POLY_DIR   = ./crypto_core/jump/polymul
DIV_DIR    = ./crypto_core/jump/divstepsx
MATRIX_DIR = ./crypto_core/jump/matrixmul
COMM_DIR  = ../fake-supercop
TEST_DIR  = ./tests


CFLAGS := $(CFLAGS) -O3
INCPATH  := -I/usr/local/include -I/opt/local/include -I/usr/include -I$(SRC_DIR) -I$(COMM_DIR) -I$(TEST_DIR) -I$(REF_DIR)
LDFLAGS  := $(LDFLAGS) #-fsanitize=address
LIBPATH  = -L/usr/local/lib -L/opt/local/lib -L/usr/lib

ifeq ($(PROJ), crypto_core/jump)
SRC_EXT_DIRS  += $(POLY_DIR)  $(DIV_DIR)   $(MATRIX_DIR)
INCPATH      += -I$(POLY_DIR)  -I$(DIV_DIR)  -I$(MATRIX_DIR)
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
SRCS    +=  $(wildcard $(SRC_DIR)/*.c)  $(wildcard $(SRC_DIR)/*.S)  $(wildcard $(REF_DIR)/*.c)
ifeq ($(PROJ),crypto_core/jump)
	SRCS    +=  $(wildcard $(POLY_DIR)/*.S)
endif


SRCS_O         :=  $(SRCS:.c=.o)
SRCS_O         :=  $(SRCS_O:.S=.o)
SRCS_O_NOTDIR  :=  $(notdir $(SRCS_O))

OBJS = $(SRCS_O_NOTDIR)

OS := $(shell uname -s)
ifeq  ($(OS), Darwin)
CFLAGS    +=  -D_MAC_OS_
OBJS      +=  m1cycles.o
endif

.INTERMEDIATE:  $(OBJS)


.PHONY: all tests #clean

all:

polymul: polymul_test.o $(OBJS)
	$(LD) $(LDFLAGS) $(LIBPATH) -o test.exe $^ $(LIBS)
	./test.exe

recip: $(OBJS) recip_test.o 
	$(LD) $(LDFLAGS) $(LIBPATH) -o recip.exe $^ $(LIBS)
	./recip.exe


%.o: $(REF_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(SRC_DIR)/%.S
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(SRC_DIR)/$(POLY)/%.S
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(COMM_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(TEST_DIR)/%.S
	$(CC) $(CFLAGS) $(INCPATH) -c $<

define GEN_O
%.o: $(1)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $$<
endef
$(foreach dir, $(SRC_EXT_DIRS), $(eval $(call GEN_O,$(dir))))

clang-format:
	clang-format -i crypto_core/invsntrup761/divstepNeon/**/*.c
	clang-format -i crypto_core/invsntrup761/divstepNeon/**/*.h
	clang-format -i tests/*.c
	clang-format -i tests/*.h

clean:
	-rm *.o *.exe *-test *-benchmark massif.out.* *-time ttt.txt