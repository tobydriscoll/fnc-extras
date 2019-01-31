CHAPS = chapter01 chapter02 chapter03 chapter04 chapter05 \
chapter06 chapter07 chapter08 chapter09 chapter10 \
chapter11 chapter12 chapter13

CONVERT=jupyter nbconvert
NBFLAGS=--to script

# Look for all the notebooks that need to be converted. 
NOTEBOOKS = $(foreach ch,$(CHAPS),$(wildcard ../$(ch)/*.ipynb))
OBJS = $(foreach nb,$(NOTEBOOKS),$(patsubst ../%.ipynb,%.jl,$(nb)))

# where to look for the sources
vpath %.ipynb ..

all: $(OBJS) 

%.jl: %.ipynb
	$(CONVERT) $(NBFLAGS) --output ../scripts/$(basename $@) $^
