% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scdataMulti.R
\name{scdataMulti}
\alias{scdataMulti}
\title{Data Preparation for \code{scest} or \code{scpi} for Point Estimation and Inference Procedures Using Synthetic Control Methods.}
\usage{
scdataMulti(
  df,
  id.var,
  time.var,
  outcome.var,
  treatment.var,
  features = NULL,
  cov.adj = NULL,
  cointegrated.data = FALSE,
  post.est = NULL,
  units.est = NULL,
  donors.est = NULL,
  anticipation = 0,
  effect = "unit-time",
  constant = FALSE,
  verbose = TRUE,
  sparse.matrices = FALSE
)
}
\arguments{
\item{df}{a dataframe object.}

\item{id.var}{a character with the name of the variable containing units' IDs. The ID variable can be numeric or character.}

\item{time.var}{a character with the name of the time variable. The time variable has to be numeric, integer, or Date. In
case \code{time.var} is Date it should be the output of \code{\link{as.Date}()} function. An integer or
numeric time variable is suggested when working with yearly data, whereas for all other formats a Date type
time variable is preferred.}

\item{outcome.var}{a character with the name of the outcome variable. The outcome variable has to be numeric.}

\item{treatment.var}{a character with the name of the variable containing the treatment assignment of each unit. The referenced
variable has to take value 1 if the unit is treated in that period and value 0 otherwise. Please notice that, as common in the SC
literature, we presume that once a unit is treated it remains treated forever. If treatment.var does not comply with this requirement
the command would not work as expected!}

\item{features}{a list containing the names of the feature variables used for estimation.
If this option is not specified the default is \code{features = outcome.var}.}

\item{cov.adj}{a list specifying the names of the covariates to be used for adjustment for each feature. If \code{outcome.var} is
not in the variables specified in \code{features}, we force \code{cov.adj<-NULL}. See the \strong{Details} section for more.}

\item{cointegrated.data}{a logical that indicates if there is a belief that the data is cointegrated or not. The default value is \code{FALSE}.}

\item{post.est}{a scalar specifying the number of post-treatment periods or a list specifying the periods
for which treatment effects have to be computed for each treated unit. It is only effective when effect = "unit-time".}

\item{units.est}{a list specifying the treated units for which treatment effects have to be computed.}

\item{donors.est}{a list specifying the donors units to be used. If the list has length 1, then all treated units share the same
potential donors. Otherwise, if the user requires different donor pools for different treated units, the list must be of the same
length of the number of treated units and each element has to be named with one treated unit's name as specified in id.var.}

\item{anticipation}{a scalar that indicates the number of periods of potential anticipation effects. Default is 0.}

\item{effect}{a string indicating the type of treatment effect to be computed. Options are: 'unit-time', which estimates treatment effects for each
treated unit- post treatment period combination; 'unit', which estimates the treatment effect for each unit by averaging post-treatment features over time;
'time', which estimates the average treatment effect on the treated at various horizons.}

\item{constant}{a logical which controls the inclusion of a constant term across features. The default value is \code{FALSE}.}

\item{verbose}{if \code{TRUE} prints additional information in the console.}

\item{sparse.matrices}{if \code{TRUE} all block diagonal matrices (\eqn{\mathbf{B}}, \eqn{\mathbf{C}}, and \eqn{\mathbf{P}})
are sparse matrices. This is suggested if the dimension of the dataset is large as it will likely reduce the execution time.
The sparse matrices will be objects of class 'dgCMatrix' or 'lgCMatrix', thus to visualize them they need to be transformed
in matrices, e.g. \code{View(as.matrix(B))}.}
}
\value{
The command returns an object of class 'scdataMulti' containing the following
\item{A}{a matrix containing pre-treatment features of the treated units.}
\item{B}{a matrix containing pre-treatment features of the control units.}
\item{C}{a matrix containing covariates for adjustment.}
\item{P}{a matrix whose rows are the vectors used to predict the out-of-sample series for the synthetic units.}
\item{P.diff}{for internal use only.}
\item{Y.df}{a dataframe containing the outcome variable for all units.}
\item{Y.pre}{a matrix containing the pre-treatment outcome of the treated units.}
\item{Y.post}{a matrix containing the post-treatment outcome of the treated units.}
\item{Y.donors}{a matrix containing the pre-treatment outcome of the control units.}
\item{specs}{a list containing some specifics of the data:
\itemize{
\item{\code{J}, a list containing the number of donors for each treated unit}
\item{\code{K}, a list containing the number of covariates used for adjustment for each feature for each treated unit}
\item{\code{KM}, a list containing the total number of covariates used for adjustment for each treated unit}
\item{\code{M}, a list containing number of features used for each treated unit}
\item{\code{I}, number of treated units}
\item{\code{KMI}, overall number of covariates used for adjustment}
\item{\code{period.pre}, a list containing a numeric vector with the pre-treatment period for each treated unit}
\item{\code{period.post}, a list containing a numeric vector with the post-treatment period for each treated unit}
\item{\code{T0.features}, a list containing a numeric vector with the number of periods used in estimation for each feature for each treated unit}
\item{\code{T1.outcome}, a list containing the number of post-treatment periods for each treated unit}
\item{\code{features.list}, a list containing the name of the features for each treated unit}
\item{\code{outcome.var}, a character containing the name of the outcome variable}
\item{\code{constant}, for internal use only}
\item{\code{effect}, for internal use only}
\item{\code{anticipation}, number of periods of potential anticipation effects}
\item{\code{out.in.features}, for internal use only}
\item{\code{sparse.matrices}, for internal use only}
\item{\code{treated.units}, list containing the IDs of all treated units}
\item{\code{donors.list}, list containing the IDs of the donors of each treated unit}}}
}
\description{
The command prepares the data to be used by \code{\link{scest}} or \code{\link{scpi}} to implement estimation
and inference procedures for Synthetic Control (SC) methods
in the general case of multiple treated units and staggered adoption. It is a generalization of \code{\link{scdata}}, since this latter prepares
the data in the particular case of a single treated unit.

The names of the output matrices follow the terminology proposed in \insertCite{cattaneo2021methodological-JASA;textual}{scpi} and
\insertCite{cattaneo2025methodological-RESTAT;textual}{scpi}.

Companion \href{https://www.stata.com/}{Stata} and \href{https://www.python.org/}{Python} packages are described in
\insertCite{cattaneo2025software-JSS;textual}{scpi}.

Companion commands are: \link{scdataMulti} for data preparation in the multiple treated units case with staggered adoption,
\link{scest} for point estimation, \link{scpi} for inference procedures, \link{scplot} and \link{scplotMulti} for plots in
the single and multiple treated unit(s) cases, respectively.

Related Stata, R, and Python packages useful for inference in SC designs are described in the following website:

\href{https://nppackages.github.io/scpi/}{ https://nppackages.github.io/scpi/}

For an introduction to synthetic control methods, see \insertCite{abadie2021UsingSyntheticControls;textual}{scpi} and references therein.

\strong{Variable Naming Convention}: due to how \code{scpi} handles object internally, we kindly ask the users of the
\code{R} version of the package to avoid including dots in the variable names. For example, "y.var" would generate
issues with some parts of the code, whereas "yvar" or "y_var" would not.
}
\details{
\itemize{
\item{\strong{Covariate-adjustment.} See the \strong{Details} section in \code{\link{scdata}} for further information on how
to specify covariate-adjustment feature-by-feature.}

\item{\strong{Cointegration.} \code{cointegrated.data} allows the user to model the belief that \eqn{\mathbf{A}} and \eqn{\mathbf{B}} form a
cointegrated system. In practice, this implies that when dealing with the pseudo-true
residuals \eqn{\mathbf{u}}, the first-difference of \eqn{\mathbf{B}} are used rather than the levels.}

\item{\strong{Effect.} \code{effect} allows the user to select between two causal quantities. The default
option, \code{effect = "unit-time"}, prepares the data for estimation of
\deqn{\tau_{ik},\quad k\geq, i=1,\ldots,N_1,}
whereas the option \code{effect = "unit"} prepares the data for estimation of
\deqn{\tau_{\cdot k}=\frac{1}{N_1} \sum_{i=1}^{N_1} \tau_{i k}}
which is the average effect on the treated unit across multiple post-treatment periods.}
}
}
\examples{

datager <- scpi_germany

datager$tr_id <- 0
datager$tr_id[(datager$country == "West Germany" & datager$year > 1990)] <- 1
datager$tr_id[(datager$country == "Italy" & datager$year > 1992)] <- 0

outcome.var <- "gdp"
id.var <- "country"
treatment.var <- "tr_id"
time.var <- "year"
df.unit <- scdataMulti(datager, id.var = id.var, outcome.var = outcome.var,
                       treatment.var = treatment.var,
                       time.var = time.var, features = list(c("gdp", "trade")),
               		    cointegrated.data = TRUE, constant = TRUE)

}
\references{
\insertAllCited{}
}
\seealso{
\code{\link{scdata}}, \code{\link{scest}}, \code{\link{scpi}}, \code{\link{scplot}}, \code{\link{scplotMulti}}
}
\author{
Matias Cattaneo, Princeton University. \email{cattaneo@princeton.edu}.

Yingjie Feng, Tsinghua University. \email{fengyj@sem.tsinghua.edu.cn}.

Filippo Palomba, Princeton University (maintainer). \email{fpalomba@princeton.edu}.

Rocio Titiunik, Princeton University. \email{titiunik@princeton.edu}.
}
