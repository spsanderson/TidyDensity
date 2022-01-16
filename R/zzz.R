# On library attachment, print message to user.
.onAttach <- function(libname, pkgname) {

    bsu_rule_color <- "#2c3e50"
    bsu_main_color <- "#1f78b4"

    # Check Theme: If Dark, Update Colors
    tryCatch({
        if (rstudioapi::isAvailable()) {
            theme <- rstudioapi::getThemeInfo()
            if (is.null(theme)) {
                bsu_rule_color <- "#2c3e50"
                bsu_main_color <- "#1f78b4"
            }
            if (theme$dark) {
                bsu_rule_color <- "#7FD2FF"
                bsu_main_color <- "#18bc9c"
            }
        }
    }, error = function(e) {
        bsu_rule_color <- "#2c3e50"
        bsu_main_color <- "#1f78b4"
    }, finally = {
        bsu_main <- crayon::make_style(bsu_main_color)

        msg <- paste0(
            cli::rule(left = "Welcome to TidyDensity", col = bsu_rule_color, line = 2),
            bsu_main('\nIf you find this package useful, please leave a star: https://github.com/spsanderson/TidyDensity'),
            bsu_main('\nIf you encounter a bug or want to request an enhancement please file an issue at:'),
            bsu_main('\n   https://github.com/spsanderson/TidyDensity/issues'),
            bsu_main('\nThank you for using TidyDensity!')
        )

        packageStartupMessage(msg)
    })

}
