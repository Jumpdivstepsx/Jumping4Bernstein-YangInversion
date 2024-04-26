CC=    gcc
LD=    gcc

PROJ   ?= crypto_core/jump
REF    ?= crypto_core/div

SRC_DIR  = $(PROJ)
REF_DIR  = $(REF)

SRC_EXT_DIR =
POLY = crypto_core/jump/polymul

POLY_DIR   = ./crypto_core/jump/polymul
MATRIX_DIR = ./crypto_core/jump/matrixmul
DIV_DIR    = ./crypto_core/jump/divstepsx
JUMP_DIR   = ./crypto_core/jump/jump
COMM_DIR  = ../fake-supercop
CYCLE_DIR = ../cycles
TEST_DIR  = ./tests

CFLAGS := $(CFLAGS) -O3 -I$(CYCLE_DIR) 
INCPATH  := -I/usr/local/include -I/opt/local/include -I/usr/include -I$(SRC_DIR) -I$(COMM_DIR) -I$(TEST_DIR) -I$(REF_DIR)
LDFLAGS  := $(LDFLAGS) #-fsanitize=address
LIBPATH  = -L/usr/local/lib -L/usr/lib

ifeq ($(PROJ), crypto_core/jump)
SRC_EXT_DIRS  += $(POLY_DIR)   $(MATRIX_DIR)   $(DIV_DIR)   $(JUMP_DIR)
INCPATH      += -I$(POLY_DIR) -I$(MATRIX_DIR)  -I$(DIV_DIR)  -I$(JUMP_DIR)
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
CFLAGS    +=  -D_MAC_
OBJS      +=  m1cycles.o
TD		  +=  m1cycles.o
endif



FROM	:= $(foreach dir, $(DIV_DIR), $(wildcard  $(dir)/*.c)) 
FROM	+= $(wildcard $(POLY_DIR)/m1.S)
FROM	+= $(wildcard $(REF_DIR)/*.c)
#$(info ============)
#$(info $(FROM))
#$(info ============)
FROM_O	:= $(FROM:.c=.o)
FROM_O	:= $(FROM_O:.S=.o)
#$(info ============)
#$(info $(FROM_O))
#$(info ============)
FROM_O_NOTDIR	:= $(notdir $(FROM_O))

TD	+= $(FROM_O_NOTDIR)



.INTERMEDIATE:  $(OBJS)

.PHONY: all tests #clean

all:

div: div_test.o $(OBJS)
	$(LD) $(LDFLAGS) $(LIBPATH) -o test.exe $^ $(LIBS)
	./test.exe

polymul: polymul_test.o $(OBJS)
	$(LD) $(LDFLAGS) $(LIBPATH) -o test.exe $^ $(LIBS)
	./test.exe

recip: $(OBJS) recip_test.o 
	$(LD) $(LDFLAGS) $(LIBPATH) -o recip.exe $^ $(LIBS)
	./recip.exe

%.o: $(CYCLE_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(POLY)/%.S
#$(CC) -arch arm64 -o $<
	$(CC) $(CFLAGS) -c $<

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(REF_DIR)/%.c
	$(CC) $(CFLAGS) $(INCPATH) -c $<

%.o: $(COMM_DIR)/%.c
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
