CHAPS = chapter01 chapter02 chapter03 chapter04 chapter05 \
chapter06 chapter07 chapter08 chapter09 chapter10 \
chapter11 chapter12 chapter13

CONVERT=jupyter nbconvert
NBFLAGS=--to html

NOTEBOOKS = $(foreach ch,$(CHAPS),$(wildcard ../$(ch)/*.ipynb))
OBJS = $(foreach nb,$(NOTEBOOKS),$(patsubst ../%.ipynb,%.html,$(nb)))
GIFS = $(foreach nb,$(NOTEBOOKS),$(patsubst ../%.ipynb,%*.gif,$(nb)))
#OBJS = $(foreach ch,$(CHAPS),$(wildcard $(ch)/*.html))

# where to look for the sources
vpath %.ipynb ..

all: $(OBJS) 

%.html: %.ipynb
	-$(CONVERT) $(NBFLAGS) --output ../html/$@ $^
	-cp $(patsubst %.ipynb,%*.gif,$^) $(dir $@)
 