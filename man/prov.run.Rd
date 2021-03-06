% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/API.R
\name{prov.init}
\alias{prov.init}
\alias{prov.save}
\alias{prov.quit}
\alias{prov.run}
\title{Provenance Collection Functions}
\usage{
prov.init(r.script.path = NULL, prov.dir = NULL, overwrite = TRUE,
  annotate.inside.functions = FALSE, first.loop = 1, max.loops = 0,
  max.snapshot.size = 0, hash.algorithm = "md5")

prov.save(save.debug = FALSE)

prov.quit(save.debug = FALSE)

prov.run(r.script.path = NULL, prov.dir = NULL, overwrite = TRUE,
  f = NULL, annotate.inside.functions = FALSE, first.loop = 1,
  max.loops = 0, max.snapshot.size = 0, save.debug = FALSE,
  display = FALSE, hash.algorithm = "md5")
}
\arguments{
\item{r.script.path}{the full path to the R script file
that is being executed. If provided, a copy of the script will
be saved with the provenance graph.}

\item{prov.dir}{the directory where the provenance graph will be 
saved. If not provided, the directory specified by the prov.dir 
option is used. Otherwise the R session temporary directory
is used.}

\item{overwrite}{if FALSE, includes a time stamp in the provenance
graph directory name.}

\item{annotate.inside.functions}{if TRUE, provenance is collected 
inside functions.}

\item{first.loop}{the first loop to collect provenance in a for, 
while, or repeat statement.}

\item{max.loops}{the maximum number of loops to collect
provenance in a for, while, or repeat statement. If max.loops = -1,
there is no limit. If max.loops = 0, no loops are annotated. 
If non-zero, it indicates the number of iterations of each loop for
which provenance should be collected.  If max.loops is non-zero, provenance
is also collected inside if-statements.}

\item{max.snapshot.size}{the maximum size for snapshot files. 
If 0, no snapshot files are saved.
If -1, the complete state of an object is stored in the snapshot
file. For other values, the head of the object, truncated to a size near
the specified limit, is saved.  The size is in kilobytes.}

\item{hash.algorithm}{the hash algorithm to use for files.
Choices are md5 (default), sha1, crc32, sha256, sha512, xxhash32, 
xxhash64 and murmur32. This feature uses the digest function from 
the digest package.}

\item{save.debug}{If TRUE, debug files are saved to the debug directory.
This is intended for developers of the RDataTracker package.}

\item{f}{a function to run. If supplied, the function f is executed 
with calls to prov.init and prov.save so that provenance for the 
function is captured.  Exactly one of f and r.script.path should be provided.}

\item{display}{if TRUE, the provenance graph is displayed in DDG Explorer}
}
\value{
prov.init initializes the provenance collector.  The prov.init
  function does not return a value.

prov.save writes the current provenance to a file but does not 
  return a value.

prov.quit writes the current provenance to a file but does not 
  return a value.

prov.run runs a script, collecting provenance as it does so.  
  It does not return a value.
}
\description{
prov.init intializes a new provenance graph. Called by the user
in console mode.

prov.save saves the current provenance graph to a prov-json file.
If more R statements are executed, the provenance for these statements
is added to the graph. The graph is finalized with prov.quit.
Called by the user in console mode.

prov.quit saves and closes the current provenance graph.
Called by the user in console mode.

prov.run initiates execution of a script and collects provenance as 
the script executes.
}
\details{
RDataTracker is an R package that collects provenance as an R script 
executes. The resulting provenance provides a detailed record of the 
execution of the script and includes information on the steps that were 
performed and the intermediate data values that were created. The 
resulting provenance can be used for a wide variety of applications
that include debugging scripts, cleaning code, and reproducing results.

There are two ways in which a user can collect provenance.  To collect
provenance from commands stored in a script file, use prov.run.  This
will execute the commands that are in the script, collecting provenance
as it does so.

The user can also collect provenance while executing commands in the 
console.  To do this, first execute prov.init.  Then enter console
commands as normal.  When done with the commands for which you want
provenance, use prov.quit.  If you want to save the current provenance
without turning off provenance collection, call prov.save instead of
prov.quit.  You can call prov.save multiple times before calling prov.quit.
Each call will append to the same provenance file.

The provenance is stored in PROV-JSON format. For immediate use it may
be retrieved from memory using the prov.json function. For later use
the provenance is also written to the file prov.json. This file and
associated files are written by default to the R session temporary
directory. The user can change this location by (1) using the optional
parameter prov.dir in the prov.run or prov.init functions, or (2) setting
the prov.dir option (e.g. by using the R options command or editing the
Rprofile.site or .Rprofile file). If prov.dir is set to ".", the current working
directory is used.

The level of detail collected by RDataTracker may be set using parameters
of the prov.run and prov.init functions. Options include collecting
provenance inside functions and inside control constructs and saving
snapshots of large intermediate values as separate files. These
features are turned off by default to optimize performance. Common
settings for the level of detail can also be set and managed using the 
prov.set.detail and related functions.
}
\examples{
\dontrun{prov.run ("script.R")}
prov.init ()
a <- 1
b <- 2
prov.save ()
ab <- a + b
prov.quit ()
}
\seealso{
\code{\link{prov.json}} for access to the JSON text of the provenance, 
  \code{\link{prov.display}} to view the provenance graphically. 
  \code{\link{prov.set.detail}} to see an alternative way to set the amount of
    provenance collected.
  \code{\link{prov.annotate.on}} and \code{\link{prov.annotate.off}} to see how to control
    annotation of individual functions
}
