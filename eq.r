eq <- read.csv("eq.csv")
  # read some data
  # [happened to catch Japan quake activity in 7 day window, so preserved eq]
eq.live <- read.csv("http://earthquake.usgs.gov/earthquakes/catalogs/eqs7day-M1.txt")
  # can also read direct from realtime web source (via data.gov / usgs)

class(eq)
  # data.frames are data structures of rows, columns
names(eq)
  # the column names
nrow(eq)
  # how many rows / samples?
head(eq)
  # some rows
  # "It's Unix, I know this!":  see also tail, ls, rm, grep, cat, etc.

mag <- eq$Magnitude
mag
  # grab a vector (each column is a vector...R is columnar)
  # where Ruby says "everything an object", R says "everything a vector"

1:10 * pi
  # and so operations are by default vector operations
  # ...back to earthquakes

mean(mag)
  # central tendency around 3.5
sd(mag)
  # sense of "spread"...about 2/3 of them lie between ~ 1.5 and 5
quantile(mag, probs=(1:10/10), na.rm=T)
  # some deciles
summary(mag)
  # handy typical summary stats
summary(eq)
  # hmm, polymorphic methods (less apparent, but R has objects too)

sapply(eq, class)
  # what's it doing with the columns?
  # generally does the right thing, but dates are sometimes tricky
eq$Datetime <- strptime(eq$Datetime, format="%A, %B %d, %Y %H:%M:%S", tz="UTC")
eq.live$Datetime <- strptime(eq.live$Datetime, format="%A, %B %d, %Y %H:%M:%S", tz="UTC")
  # fix up the dates
plot(eq$Datetime, eq$Magnitude)
hist(eq$Magnitude)
  # some plots...bimodal, something going on here

eq$Japan <- grepl("Japan", eq$Region)
  # add a column
jp <- eq[eq$Japan,]
plot(jp$Datetime, jp$Magnitude)
  # let's just look at Japan

where <- table(eq$Region)
head(sort(unlist(where), dec=T), n=25)
  # where are these quakes?
  # whoa Utah!
eq[grepl("Utah", eq$Region),]
  # any shaking near here?
eq.live[grepl("Utah", eq.live$Region) & eq.live$Datetime >= as.POSIXlt("2010-03-17 00:00:00"),]
  # any shaking *during* the conf days?
