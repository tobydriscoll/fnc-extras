CHAPS = chapter01 chapter02 chapter03 chapter04 chapter05 \
chapter06 chapter07 chapter08 chapter09 chapter10 \
chapter11 chapter12 chapter13

CONVERT=jupyter nbconvert
NBFLAGS=--ExecutePreprocessor.allow_errors=True \
--ExecutePreprocessor.timeout=120 \
--to html --execute
#--ExecutePreprocessor.kernel_name='julia-1.1' 

NOTEBOOKS = $(foreach ch,$(CHAPS),$(wildcard ../$(ch)/*.ipynb))
OBJS = $(foreach nb,$(NOTEBOOKS),$(patsubst ../%.ipynb,%.html,$(nb)))
#OBJS = $(foreach ch,$(CHAPS),$(wildcard $(ch)/*.html))

# where to look for the sources
vpath %.ipynb ..

all: $(OBJS) 

%.html: %.ipynb
	$(CONVERT) $(NBFLAGS) --output ../html/$@ $^
