#great reference (Example)
https://github.com/cran/HH/tree/a6ee768cedcebd4477bb9a5b4d0baa3d16e4dca0/demo

#?likert from HH command

likert {HH}	R Documentation
Diverging stacked barcharts for Likert, semantic differential, rating scale data, and population pyramids.
Description
Constructs and plots diverging stacked barcharts for Likert, semantic differential, rating scale data, and population pyramids.

Usage
likert(x, ...)
likertplot(x, ...)
## S3 method for class 'likert'
plot(x, ...)

## S3 method for class 'formula'
plot.likert(x, data, ReferenceZero=NULL, value, levelsName="",
                                scales.in=NULL,   ## use scales=
                                between=list(x=1 + (horizontal), y=.5 + 2*(!horizontal)),
                                auto.key.in=NULL, ## use auto.key=
                                panel.in=NULL,    ## use panel=
                                horizontal=TRUE,
                                par.settings.in=NULL, ## use par.settings=
                                ...,
                                as.percent = FALSE,
                                ## titles
                                ylab= if (horizontal) {
                                  if (length(x)==3)
                                    deparse(x[[2]])
                                  else
                                    "Question"
                                }
                                else
                                if (as.percent != FALSE) "Percent" else "Count",

                                xlab= if (!horizontal) {
                                  if (length(x)==3)
                                    deparse(x[[2]])
                                  else
                                    "Question"
                                }
                                else
                                if (as.percent != FALSE) "Percent" else "Count",

                                main = x.sys.call,

                                ## right axis
                                rightAxisLabels = rowSums(data.list$Nums),
                                rightAxis = !missing(rightAxisLabels),
                                ylab.right = if (rightAxis) "Row Count Totals" else NULL,
                                xlab.top = NULL,
                                right.text.cex =
                                  if (horizontal) { ## lazy evaluation
                                    if (!is.null(scales$y$cex)) scales$y$cex else .8
                                  }
                                  else
                                    {
                                      if (!is.null(scales$x$cex)) scales$x$cex else .8
                                    },

                                ## scales
                                xscale.components = xscale.components.top.HH,
                                yscale.components = yscale.components.right.HH,
                                xlimEqualLeftRight = FALSE,
                                xTickLabelsPositive = TRUE,

                                ## row sequencing
                                as.table=TRUE,
                                positive.order=FALSE,
                                data.order=FALSE,
                                reverse=ifelse(horizontal, as.table, FALSE),

                                ## resizePanels arguments
                                h.resizePanels=sapply(result$y.used.at, length),
                                w.resizePanels=sapply(result$x.used.at, length),

                                ## color options
                                reference.line.col="gray65",
                                col.strip.background="gray97",
                                key.border.white=TRUE,
                                col=likertColor(Nums.attr$nlevels,
                                  ReferenceZero=ReferenceZero,
                                  colorFunction=colorFunction,
                                  colorFunctionOption=colorFunctionOption),
                                colorFunction="diverge_hcl",
                                colorFunctionOption="lighter"
                                )
## S3 method for class 'matrix'
plot.likert(x,
            positive.order=FALSE,
            ylab=names(dimnames(x)[1]),
            xlab=if (as.percent != FALSE) "Percent" else "Count",
            main=xName,
            reference.line.col="gray65",
            col.strip.background="gray97",
            col=likertColor(attr(x, "nlevels"),
              ReferenceZero=ReferenceZero,
              colorFunction=colorFunction,
              colorFunctionOption=colorFunctionOption),
            colorFunction="diverge_hcl",
            colorFunctionOption="lighter",
            as.percent=FALSE,
            par.settings.in=NULL,
            horizontal=TRUE,
            ReferenceZero=NULL,
            ...,
            key.border.white=TRUE,
            xName=deparse(substitute(x)),
            rightAxisLabels=rowSums(abs(x)),
            rightAxis=!missing(rightAxisLabels),
            ylab.right=if (rightAxis) "Row Count Totals" else NULL,
            panel=panel.barchart,
            xscale.components=xscale.components.top.HH,
            yscale.components=yscale.components.right.HH,
            xlimEqualLeftRight=FALSE,
            xTickLabelsPositive=TRUE,
            reverse=FALSE)

## Default S3 method:
plot.likert(x, ...)  ## calls plot.likert.matrix

## S3 method for class 'array'
plot.likert(x,
             condlevelsName=paste("names(dimnames(", xName, "))[-(1:2)]",
                                  sep=""),
             xName=deparse(substitute(x)),
             main=paste("layers of", xName, "by", condlevelsName),
             ...)

## S3 method for class 'likert'
plot.likert(x, ...)  ## See Details

## S3 method for class 'list'
plot.likert(x,  ## named list of matrices, 2D tables,
                               ## 2D ftables, or 2D structables,
                               ## or all-numeric data.frames
            condlevelsName="ListNames",
            xName=deparse(substitute(x)),
            main=paste("List items of", xName, "by", condlevelsName),
            layout=if (length(dim.x) > 1) dim.x else {
                               if (horizontal) c(1, length(x)) else c(length(x), 1)},
            positive.order=FALSE,
            strip=!horizontal,
            strip.left=horizontal,
            strip.left.values=names(x),
            strip.values=names(x),
            strip.par=list(cex=1, lines=1),
            strip.left.par=list(cex=1, lines=1),
            horizontal=TRUE,
            ...,
            rightAxisLabels=sapply(x, function(x) rowSums(abs(x)), simplify = FALSE),
            rightAxis=!missing(rightAxisLabels),
            resize.height.tuning=-.5,
            resize.height=if (missing(layout) || length(dim.x) != 2) {
              c("nrow","rowSums")
            } else {
              rep(1, layout[2])
            },
            resize.width=if (missing(layout)) {1 } else {
              rep(1, layout[1])
            },
            box.ratio=if (
              length(resize.height)==1 &&
              resize.height == "rowSums") 1000 else 2,
            xscale.components=xscale.components.top.HH,
            yscale.components=yscale.components.right.HH)

## S3 method for class 'table'
plot.likert(x, ..., xName=deparse(substitute(x)))
## S3 method for class 'ftable'
plot.likert(x, ..., xName=deparse(substitute(x)))
## S3 method for class 'structable'
plot.likert(x, ..., xName=deparse(substitute(x)))

## S3 method for class 'data.frame'
plot.likert(x, ..., xName=deparse(substitute(x)))


xscale.components.top.HH(...)
yscale.components.right.HH(...)
Arguments
x	
For the formula method, a model formula. All terms in the formula must be the names of columns in the data.frame argument data or the special abbreviation . only on the right-hand-side. Functions of the names will not work. The right-hand-side must be either . or the sum of the names of numeric variables in data. Non-syntactic names must be in quotes (single ⁠'⁠ or double ⁠"⁠), but not backticks ⁠`⁠. The . on the right-hand-side is expanded to the formula containing the sum of all remaining (after the response and the conditioning variables) numeric columns in data. An empty left-hand-side is interpreted as the rownames(data). See the examples for all possible forms of formula recognized by the likert function.

Otherwise, any numeric object stored as a vector, matrix, array, data.frame, table, ftable, structable (as defined in the vcd package), or as a list of named two-dimensional objects. This is the only required argument. See the Details section for restrictions on the form of data.frame, list, ftable, and structable arguments.

data	
For the formula method, a data.frame. Do not use variable names ".value" or ".variable".

ReferenceZero	
Numeric scalar or NULL. The position in the range
seq(0, attr(x, "nlevels")+.5, .5) where the reference line at 0 will be placed. attr(x, "nlevels") is the number of columns of the original argument x, before it has been coerced to a "likert" object. The default NULL corresponds to the middle level if there are an odd number of levels, and to half-way between the two middle levels if there are an even number of levels. This argument is used when the number of positive levels and the number of negative levels are not the same. For example, with 4 levels
c("Disagree", "Neutral", "Weak Agree", "Strong Agree"), the argument would be specified ReferenceZero=2 indicating that the graphical split would be in the middle of the second group with label "Neutral".

value	
Name of the numeric variable containing the data when the formula method is used with the long data form. The predictor in the formula will be a factor name. The name of the predictor will be used as the title in the key.

levelsName	
(optional) Name of the implied factor distinguishing the columns of the response variables when the formula method is used with the wide data form. This name will be used as the title in the key.

positive.order	
If FALSE, the default value, the original order of the rows is retained. This is necessary for arrays, because each panel has the same rownames. If TRUE, rows are ordered within each panel with the row whose bar goes farthest to the right at the top of a panel of horizontal bars or at the left of a panel of vertical bars. positive.order is frequently set to TRUE for lists.

data.order	
formula method only. If positive.order is TRUE, this data.order variable is ignored. If FALSE, the default value, and the rows are specified by a factor, then they are ordered by their levels. If TRUE, then the rows are ordered by their order in the input data.frame.

as.percent	
When as.percent==TRUE or as.percent=="noRightAxis", then the values in each row are rescaled to row percents. When as.percent==TRUE the original row totals are used as rightAxisLabels, rightAxis is set to TRUE, the ylab.right is by default set to "Row Count Totals" (the user can change its value in the calling sequence). When as.percent=="noRightAxis", then rightAxis will be set to FALSE.

as.table	
Standard lattice argument. See barchart.

par.settings.in, scales.in, auto.key.in, panel.in	
These are placeholders for lattice arguments that lets the user specify some lattice par.settings and still retain the ones that are prespecified in the
plot.likert.default.

ylab, xlab, ylab.right, xlab.top, main	
Standard lattice graph labels in barchart.

right.text.cex	
The right axis, as used here for the "Row Count Totals", has non-standard controls. It's cex follows the cex of the left axis, unless this argument is used to override that value. When horizontal=FALSE, then the top axis defaults to follow the bottom axis unless overridden by right.text.cex.

between	
Standard lattice argument.

col	
Vector of color names for the levels of the agreement factor. Although the colors can be specified as an arbitrary vector of color names, for example, col=c('red','blue','#4AB3F2'), usually specifying one of the diverging palettes from diverge_hcl or sequential palettes from sequential_hcl will suffice. For less intense colors, you can use the middle colors from a larger set of colors; e.g., col=sequential_hcl(11)[5:2]. See the last AudiencePercent example below for this usage.

colorFunction, colorFunctionOption	
See likertColor.

reference.line.col	
Color for reference line at zero.

col.strip.background	
Background color for the strip labels.

key.border.white	
Logical. If TRUE, then place a white border around the rect in the key, else use the col of the rect itself.

horizontal	
Logical, with default TRUE indicating horizontal bars, will be passed to the barchart function by the plot.likert method. In addition, it interchanges the meaning of resize.height and resize.width arguments to the likert functions applied to arrays and lists.

...	
other arguments. These will be passed to the barchart function by the plot.likert method. The most useful of these is the border argument which defaults to make the borders of the bars the same color as the bars themselves. A scalar alternative (border="white" being our first choice) puts a border around each bar in the stacked barchart. This works very well when the ReferenceZero line is between two levels. It gives a misleading division of the central bar when the ReferenceZero is in the middle of a level. See the example in the examples section. Arguments to the lattice auto.key=list() argument (described in barchart) will be used in the legend. See the examples.

strip.left, strip	
Logical. The default strip.left=TRUE places the strip labels on the left of each panel as in the first professional challenges example. The alternative
strip.left=FALSE puts the strip labels on the top of each panel, the traditional lattice strip label position.

condlevelsName, strip.left.values, strip.values, strip.par, strip.left.par, layout	
Arguments which will be passed to ResizeEtc.

xName	
Name of the argument in its original environment.

rightAxis	
logical. Should right axis values be displayed? Defaults to FALSE unless
rightAxisLabels are specified.

rightAxisLabels	
Values to be displayed on the right axis. The default values are the row totals. These are sensible for tables of counts. When the data is rescaled to percents by the as.percent=TRUE argument, then the rightAxisLabels are still defaulted to the row totals for the counts. We illustrate this usage in the ProfChal example.

resize.height.tuning	
Tuning parameter used to adjust the space between bars as specified by the resize.height argument to the ResizeEtc function.

h.resizePanels, resize.height	
Either character scalar or numeric vector. If "nrow", then the panels heights are proportional to the number of bars in each panel. If "rowSums" and there is exactly one bar per panel, then the panels heights are proportional to the total count in each bar, and see the discussion of the box.ratio argument. If a numeric vector, the panel heights are proportional to the numbers in the argument.

w.resizePanels, resize.width	
Numeric vector. The panel widths are proportional to the numbers in the argument.

box.ratio	
If there are more than one bar in any panel, then this defaults to the trellis standard value of 2. If there is exactly one bar in a panel, then the value is 1000, with the intent to minimize the white space in the panel. In this way, when as.percent==TRUE, the bar total area is the count and the bar widths are all equal at 100%. See the example below.

panel	
panel function eventually to be used by barchart.

xscale.components, yscale.components	
See yscale.components.default. xscale.components.top.HH constructs the top x-axis labels, when needed, as the names of the bottom x-axis labels. yscale.components.right.HH constructs the right y-axis labels, when needed, as the names of the left y-axis labels. The names are placed automatically by the plot.likert methods based on the value of the arguments as.percent, rightAxis, and rightAxisLabels. By default, when rightAxis != FALSE the layout.widths are set to list(ylab.right=5, right.padding=0). Otherwise, those arguments are left at their default values. They may be adjusted with an argument of the form par.settings.in=
list(layout.widths=list(ylab.right=5, right.padding=0)).
Similarly, spacing for the top labels can be adjusted with an argument of the form par.settings.in=list(layout.heights=list(key.axis.padding=6)).

xlimEqualLeftRight	
Logical. The default is FALSE. If TRUE and at and labels are not explicitly specified, then the left and right x limits are set to negative and positive of the larger of the absolute value of the original x limits. When !horizontal, this argument applies to the y coordinate.

xTickLabelsPositive	
Logical. The default is TRUE. If TRUE and at and labels are not explicitly specified, then the tick labels on the negative side are displayed as positive values. When !horizontal, this argument applies to the y coordinate.

reverse	
Logical. The default is FALSE. If TRUE, the rows of the input matrix are reversed. The default is to plot the rows from top-to-bottom for horizontal bars and from left-to-write for vertical bars. reverse, positive.order, and horizontal are independent. All eight combinations are possible. See the
Eight sequences and orientations section in the example for all eight.

Details
The counts (or percentages) of respondents on each row who agree with the statement are shown to the right of the zero line; the counts (or percentages) who disagree are shown to the left. The counts (or percentages) for respondents who neither agree nor disagree are split down the middle and are shown in a neutral color. The neutral category is omitted when the scale has an even number of choices. It is difficult to compare lengths without a common baseline. In this situation, we are primarily interested in the total count (or percent) to the right or left of the zero line; the breakdown into strongly or not is of lesser interest so that the primary comparisons do have a common baseline of zero. The rows within each panel are displayed in their original order by default. If the argument positive.order=TRUE is specified, the rows are ordered by the counts (or percentages) who agree.

Diverging stacked barcharts are also called "two-directional stacked barcharts". Some authors use the term "floating barcharts" for vertical diverging stacked barcharts and the term "sliding barcharts" for horizontal diverging stacked barcharts.

All items in a list of named two-dimensional objects must have the same number of columns. If the items have different column names, the column names of the last item in the list will be used in the key. If the dimnames of the matrices are named, the names will be used in the plot. It is possible to produce a likert plot with a list of objects with different numbers of columns, but not with the plot.likert.list method. These must be done manually by using the ResizeEtc function on each of the individual likert plots. The difficulty is that the legend is based on the last item in the list and will have the wrong number of values for some of the panels.

A single data.frame x will be plotted as data.matrix(x[sapply(x, is.numeric)]). The subscripting on the class of the columns is there to remove columns of characters (which would otherwise be coerced to NA) and factor columns (which would otherwise be coerced to integers). A data.frame with only numeric columns will work in a named list. A list of data.frame with factors or characters will be plotted by automatically removing columns that are not numeric.

ftable and structable arguments x will be plotted as as.table(x). This changes the display sequence. Therefore the user will probably want to use aperm on the ftable or structable before using plot.likert.

The likert method is designed for use with "likert" objects created with the independent likert package. It is not recommended that the HH package and the likert package both be loaded at the same time, as they have incompatible usage of the exported function names likert and plot.likert. If the likert package is installed, it can be run without loading by using the function calls likert::likert() and likert:::plot.likert().

Value
A "trellis" object containing the plot. The plot will be automatically displayed unless the result is assigned to an object.

Note
The current version of the likert function uses the default diverging palette from diverge_hcl as the default. Previous versions used the RColorBrewer palette "RdBu" as the default color palette. The previous color palette is still available with an explicit call to likertColorBrewer, for example

col=likertColorBrewer(nc, ReferenceZero=ReferenceZero,
BrewerPaletteName="RdBu", middle.color="gray90")

Note
Ann Liu-Ferrara was a beta tester for the shiny app.

Note
Documentation note:
Most of the plots drawn by plot.likert have a long left-axis tick label. They therefore require a wider window than R's default of a nominal 7in \times× 7in window. The comments with the examples suggest aesthetic window sizes.

Technical note:
There are three (almost) equivalent calling sequences for likert plots.

likert(x) ## recommended
likert is an alias for plot.likert().

plot.likert(x)
plot.likert is both a method of plot for "likert" objects, and a generic function in its own right. There are methods of plot.likert for "formula", "matrix", "array", "table", and several other classes of input objects.

plot(as.likert(x))
Both likert and plot.likert work by calling the as.likert function on their argument x. Once as.likert has converted its argument to a "likert" object, the method dispatch technology for the generic plot.likert is in play. The user can make the explicit call as.likert(x) to see what a "likert" object looks like, but is very unlikely to want to look a second time.

Author(s)
Richard M. Heiberger, with contributions from Naomi B. Robbins <naomi@nbr-graphs.com>.

Maintainer: Richard M. Heiberger <rmh@temple.edu>

References
Richard M. Heiberger, Naomi B. Robbins (2014)., "Design of Diverging Stacked Bar Charts for Likert Scales and Other Applications", Journal of Statistical Software, 57(5), 1–32, doi:10.18637/jss.v057.i05.

Richard Heiberger and Naomi Robbins (2011), "Alternative to Charles Blow's Figure in \"Newt's War on Poor Children\"", Forbes OnLine, December 20, 2011. https://www.forbes.com/sites/naomirobbins/2011/12/20/alternative-to-charles-blows-figure-in-newts-war-on-poor-children-2/

Naomi Robbins (2011), "Visualizing Data: Challenges to Presentation of Quality Graphics—and Solutions", Amstat News, September 2011, 28–30. http://magazine.amstat.org/blog/2011/09/01/visualizingdata/

Luo, Amy and Tim Keyes (2005). "Second Set of Results in from the Career Track Member Survey," Amstat News. Arlington, VA: American Statistical Association.

See Also
barchart, ResizeEtc, as.likert, as.matrix.listOfNamedMatrices, pyramidLikert

Examples
Run examples


## See file HH/demo/likert-paper.r for a complete set of examples using
## the formula method into the underlying lattice:::barchart plotting
## technology.  See file HH/demo/likert-paper-noFormula.r for the same
## set of examples using the matrix and list of matrices methods.  See
## file HH/demo/likertMosaic-paper.r for the same set of examples using
## the still experimental functions built on the vcd:::mosaic as the
## underlying plotting technology

data(ProfChal)  ## ProfChal is a data.frame.
## See below for discussion of the dataset.


## Count plot
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",],
       main='Is your job professionally challenging?',
       ylab=NULL,
       sub="This plot looks better in a 9in x 4in window.")

## Percent plot calculated automatically from Count data
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",],
       as.percent=TRUE,
       main='Is your job professionally challenging?',
       ylab=NULL,
       sub="This plot looks better in a 9in x 4in window.")

## formula method
data(NZScienceTeaching)
likert(Question ~ . | Subtable, data=NZScienceTeaching,
       ylab=NULL,
       scales=list(y=list(relation="free")), layout=c(1,2))

## Not run: 
## formula notation with expanded right-hand-side
likert(Question ~
       "Strongly disagree" + Disagree + Neutral + Agree + "Strongly agree" |
       Subtable, data=NZScienceTeaching,
       ylab=NULL,
       scales=list(y=list(relation="free")), layout=c(1,2))

## End(Not run)

## Not run: 
## formula notation with long data arrangement
NZScienceTeachingLong <- reshape2::melt(NZScienceTeaching,
                                        id.vars=c("Question", "Subtable"))
names(NZScienceTeachingLong)[3] <- "Agreement"
head(NZScienceTeachingLong)

likert(Question ~ Agreement | Subtable, value="value", data=NZScienceTeachingLong,
       ylab=NULL,
       scales=list(y=list(relation="free")), layout=c(1,2))

## End(Not run)

## Examples with higher-dimensional arrays.
tmp3 <- array(1:24, dim=c(2,3,4),
              dimnames=list(A=letters[1:2], B=LETTERS[3:5], C=letters[6:9]))

## positive.order=FALSE is the default.  With arrays
## the rownames within each item of an array are identical.

## likert(tmp3)
likert(tmp3, layout=c(1,4))
likert(tmp3, layout=c(2,2), resize.height=c(2,1), resize.width=c(3,4))


## plot.likert interprets vectors as single-row matrices.
## http://survey.cvent.com/blog/customer-insights-2/box-scores-are-not-just-for-baseball
Responses <- c(15, 13, 12, 25, 35)
names(Responses) <- c("Strongly Disagree", "Disagree", "No Opinion",
                      "Agree", "Strongly Agree")
## Not run: 
likert(Responses, main="Retail-R-Us offers the best everyday prices.",
       sub="This plot looks better in a 9in x 2.6in window.")

## End(Not run)
## reverse=TRUE  is needed for a single-column key with
## horizontal=FALSE and with space="right"
likert(Responses, horizontal=FALSE,
       aspect=1.5,
       main="Retail-R-Us offers the best everyday prices.",
       auto.key=list(space="right", columns=1,
                     reverse=TRUE, padding.text=2),
       sub="This plot looks better in a 4in x 3in window.")


## Not run: 
## Since age is always positive and increases in a single direction,
## this example uses colors from a sequential palette for the age
## groups.  In this example we do not use a diverging palette that is
## appropriate when groups are defined by a characteristic, such as
## strength of agreement or disagreement, that can increase in two directions.

## Initially we use the default Blue palette in the sequential_hcl function.
data(AudiencePercent)
likert(AudiencePercent,
       auto.key=list(between=1, between.columns=2),
       xlab=paste("Percentage of audience younger than 35 (left of zero)",
                  "and older than 35 (right of zero)"),
       main="Target Audience",
       col=rev(colorspace::sequential_hcl(4)),
       sub="This plot looks better in a 7in x 3.5in window.")

## The really light colors in the previous example are too light.
## Therefore we use the col argument directly.  We chose to use an
## intermediate set of Blue colors selected from a longer Blue palette.
likert(AudiencePercent,
       positive.order=TRUE,
       auto.key=list(between=1, between.columns=2),
       xlab=paste("Percentage of audience younger than 35",
         "(left of zero) and older than 35 (right of zero)"),
       main="Brand A has the most even distribution of ages",
       col=colorspace::sequential_hcl(11)[5:2],
       scales=list(x=list(at=seq(-90,60,10),
                     labels=as.vector(rbind("",seq(-80,60,20))))),
      sub="This plot looks better in a 7in x 3.5in window.")

## End(Not run)


## Not run: 
## See the ?as.pyramidLikert help page for these examples
## Population Pyramid
data(USAge.table)
USA79 <- USAge.table[75:1, 2:1, "1979"]/1000000
PL <- likert(USA79,
             main="Population of United States 1979 (ages 0-74)",
             xlab="Count in Millions",
             ylab="Age",
             scales=list(
               y=list(
                 limits=c(0,77),
                 at=seq(1,76,5),
                 labels=seq(0,75,5),
                 tck=.5))
             )
PL
as.pyramidLikert(PL)

likert(USAge.table[75:1, 2:1, c("1939","1959","1979")]/1000000,
       main="Population of United States 1939,1959,1979 (ages 0-74)",
       sub="Look for the Baby Boom",
       xlab="Count in Millions",
       ylab="Age",
       scales=list(
         y=list(
           limits=c(0,77),
           at=seq(1,76,5),
           labels=seq(0,75,5),
           tck=.5)),
       strip.left=FALSE, strip=TRUE,
       layout=c(3,1), between=list(x=.5))

## End(Not run)


Pop <- rbind(a=c(3,2,4,9), b=c(6,10,12,10))
dimnames(Pop)[[2]] <- c("Very Low", "Low", "High", "Very High")
likert(as.listOfNamedMatrices(Pop),
            as.percent=TRUE,
            resize.height="rowSums",
            strip=FALSE,
            strip.left=FALSE,
            main=paste("Area and Height are proportional to 'Row Count Totals'.",
                       "Width is exactly 100%.", sep="\n"))


## Professional Challenges example.
##
## The data for this example is a list of related likert scales, with
## each item in the list consisting of differently named rows.  The data
## is from a questionnaire analyzed in a recent Amstat News article.
## The study population was partitioned in several ways.  Data from one
## of the partitions (Employment sector) was used in the first example
## in this help file.  The examples here show various options for
## displaying all partitions on the same plot.
##
data(ProfChal)
levels(ProfChal$Subtable)[6] <- "Prof Recog" ## reduce length of label

## 1. Plot counts with rows in each panel sorted by positive counts.
##
## Not run: 
likert(Question ~ . | Subtable, ProfChal,
       positive.order=TRUE,
       main="This works, but needs more specified arguments to look good")

likert(Question ~ . | Subtable, ProfChal,
       scales=list(y=list(relation="free")), layout=c(1,6),
       positive.order=TRUE,
       between=list(y=0),
       strip=FALSE, strip.left=strip.custom(bg="gray97"),
       par.strip.text=list(cex=.6, lines=5),
       main="Is your job professionally challenging?",
       ylab=NULL,
       sub="This looks better in a 10inx7in window")

## End(Not run)

ProfChalCountsPlot <-
likert(Question ~ . | Subtable, ProfChal,
       scales=list(y=list(relation="free")), layout=c(1,6),
       positive.order=TRUE,
       box.width=unit(.4,"cm"),
       between=list(y=0),
       strip=FALSE, strip.left=strip.custom(bg="gray97"),
       par.strip.text=list(cex=.6, lines=5),
       main="Is your job professionally challenging?",
       rightAxis=TRUE,  ## display Row Count Totals
       ylab=NULL,
       sub="This looks better in a 10inx7in window")
ProfChalCountsPlot


## Not run: 
## 2. Plot percents with rows in each panel sorted by positive percents.
##    This is a different sequence than the counts.  Row Count Totals are
##    displayed on the right axis.
ProfChalPctPlot <-
likert(Question ~ . | Subtable, ProfChal,
       as.percent=TRUE,    ## implies display Row Count Totals
       scales=list(y=list(relation="free")), layout=c(1,6),
       positive.order=TRUE,
       box.width=unit(.4,"cm"),
       between=list(y=0),
       strip=FALSE, strip.left=strip.custom(bg="gray97"),
       par.strip.text=list(cex=.6, lines=5),
       main="Is your job professionally challenging?",
       rightAxis=TRUE,  ## display Row Count Totals
       ylab=NULL,
       sub="This looks better in a 10inx7in window")
ProfChalPctPlot

## 3. Putting both percents and counts on the same plot, both in
##    the order of the positive percents.

LikertPercentCountColumns(Question ~ . | Subtable, ProfChal,
                          layout=c(1,6), scales=list(y=list(relation="free")),
                          ylab=NULL, between=list(y=0),
                          strip.left=strip.custom(bg="gray97"), strip=FALSE,
                          par.strip.text=list(cex=.7),
                          positive.order=TRUE,
                          main="Is your job professionally challenging?")


## Restore original name
## levels(ProfChal$Subtable)[6] <- "Attitude\ntoward\nProfessional\nRecognition"

## End(Not run)

## Not run: 
## 4. All possible forms of formula for the likert formula method:
data(ProfChal)
row.names(ProfChal) <- abbreviate(ProfChal$Question, 8)

likert( Question ~ . | Subtable,
       data=ProfChal, scales=list(y=list(relation="free")), layout=c(1,6))

likert( Question ~
          "Strongly Disagree" + Disagree + "No Opinion" + Agree + "Strongly Agree" | Subtable,
       data=ProfChal, scales=list(y=list(relation="free")), layout=c(1,6))

likert( Question ~ . ,
       data=ProfChal)

likert( Question ~ "Strongly Disagree" + Disagree + "No Opinion" + Agree + "Strongly Agree",
       data=ProfChal)

likert( ~ . | Subtable,
       data=ProfChal, scales=list(y=list(relation="free")), layout=c(1,6))

likert( ~ "Strongly Disagree" + Disagree + "No Opinion" + Agree + "Strongly Agree" | Subtable,
       data=ProfChal, scales=list(y=list(relation="free")), layout=c(1,6))

likert( ~ . ,
       data=ProfChal)

likert( ~ "Strongly Disagree" + Disagree + "No Opinion" + Agree + "Strongly Agree",
       data=ProfChal)


## End(Not run)

## Not run: 
## 5. putting the x-axis tick labels on top for horizontal plots
##    putting the y-axis tick lables on right for vertical plots
##
## This non-standard specification is a consequence of using the right
## axis labels for different values than appear on the left axis labels
## with horizontal plots, and using the top axis labels for different
## values than appear on the bottom axis labels with vertical plots.

## Percent plot calculated automatically from Count data

tmph <-
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",],
       as.percent=TRUE,
       main='Is your job professionally challenging?',
       ylab=NULL,
       sub="This plot looks better in a 9in x 4in window.")
tmph$x.scales$labels
names(tmph$x.scales$labels) <- tmph$x.scales$labels
update(tmph, scales=list(x=list(alternating=2)), xlab=NULL, xlab.top="Percent")

tmpv <-
likert(Question ~ . , ProfChal[ProfChal$Subtable=="Employment sector",],
       as.percent=TRUE,
       main='Is your job professionally challenging?',
       sub="likert plots with long Question names look better horizontally.
With effort they can be made to look adequate vertically.",
       horizontal=FALSE,
       scales=list(y=list(alternating=2), x=list(rot=c(90, 0))),
       ylab.right="Percent",
       ylab=NULL,
       xlab.top="Column Count Totals",
       par.settings=list(
         layout.heights=list(key.axis.padding=5),
         layout.widths=list(key.right=1.5, right.padding=0))
)
tmpv$y.scales$labels
names(tmpv$y.scales$labels) <- tmpv$y.scales$labels
tmpv
tmpv$x.limits <- abbreviate(tmpv$x.limits,8)
tmpv$x.scales$rot=c(0, 0)
tmpv


## End(Not run)

## Not run: 
## illustration that a border on the bars is misleading when it splits a bar.
tmp <- data.frame(a=1, b=2, c=3)
likert(~ . , data=tmp, ReferenceZero=2, main="No border. OK.")
likert(~ . , data=tmp, ReferenceZero=2, border="white",
       main="Border. Misleading split of central bar.")
likert(~ . , data=tmp, ReferenceZero=2.5, main="No border. OK.")
likert(~ . , data=tmp, ReferenceZero=2.5, border="white", main="Border. OK.")

## End(Not run)

## Not run: 
  ## run the shiny app
if (interactive())  shiny::runApp(system.file("shiny/likert", package="HH"))

## End(Not run)

## The ProfChal data is done again with explicit use of ResizeEtc
## in ?HH:::ResizeEtc

[Package HH version 3.1-49 Index]
