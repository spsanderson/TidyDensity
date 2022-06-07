#' Provide Colorblind Compliant Colors
#'
#' @family ColorBlind
#'
#' 8 Hex RGB color definitions suitable for charts for colorblind people.
#'
#' @export
color_blind <- function(){
    c("#000000", "#E69F00", "#56B4E9",
      "#009E73", "#F0E442", "#0072B2",
      "#D55E00", "#CC79A7")
}

#' Provide Colorblind Compliant Colors
#'
#' @family ColorBlind
#'
#' @param theme This defaults to `td` and that is the only allowed value
#'
#' @export
td_scale_fill_colorblind <- function(..., theme = "td") {

    pal <- switch(theme,
                  "td" = unname(color_blind()) %>% rep(100)
    )

    ggplot2::scale_fill_manual(values = pal)
}

#' Provide Colorblind Compliant Colors
#'
#' @family ColorBlind
#'
#' @param theme This defaults to `td` and that is the only allowed value
#'
#' @export
td_scale_color_colorblind = function(..., theme = "td") {

    pal <- switch(theme,
                  "td" = unname(color_blind()) %>% rep(100)
    )

    ggplot2::scale_color_manual(values = pal)
}
