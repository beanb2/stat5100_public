crAtBat_range <- seq(min(baseball$CrAtBat), max(baseball$CrAtBat), length = 500)
nBB_range <- seq(min(baseball$nBB), max(baseball$nBB), length = 500)
baseball_gam_short <- mgcv::gam(logSalary ~ mgcv::s(CrAtBat) + mgcv::s(nBB), data = baseball)
gam_pred <- function(x, y) {
  predict(baseball_gam_short, data.frame(CrAtBat = x,
                                         nBB = y))
}

z <- outer(crAtBat_range, nBB_range, gam_pred)

library(plotly)
fig = plot_ly(
  type = "surface",
  x = ~crAtBat_range,
  y = ~nBB_range,
  z = ~z
)
fig <- plotly::add_markers(
  fig,
  x = ~baseball$CrAtBat,
  y = ~baseball$nBB,
  z = ~baseball$logSalary,
  size = I(30),
  color = I("#FF0000")
)
fig <- plotly::layout(
  fig,
  scene = list(xaxis = list(title = "Career Times at Bat"),
               yaxis = list(title = "Walks in 1986"),
               zaxis = list(title = "Log Salary"))
)
fig