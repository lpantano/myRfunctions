
save_report<- function(fn){
    load(dropbox_credentials, file="~/.my_dropbox_credentials.rdata")
    dropbox_save(dropbox_credentials, b, file=paste0("Public/hsph/"),fn, verbose = TRUE, ext = ".rda")
}

render_2_drop <- function(rmd,dn)
{
    render(rmd, output_dir = paste0("~/Dropbox/Public/hsph/",dn))
}


runAllChunks <- function(rmd, envir=globalenv()){
    tempR <- tempfile(tmpdir = ".", fileext = ".R")
    on.exit(unlink(tempR))
    knitr::purl(rmd, output=tempR)
    sys.source(tempR, envir=envir)
}

