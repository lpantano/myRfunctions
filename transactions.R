require(tools)
save_report<- function(fn){
    load(dropbox_credentials, file="~/.my_dropbox_credentials.rdata")
    dropbox_save(dropbox_credentials, b, file=paste0("Public/hsph/"),fn, verbose = TRUE, ext = ".rda")
}

render_2_drop <- function(rmd,dn)
{
    path_out <- paste0("~/Dropbox/Public/hsph/",dn)
    dir.create(path_out,recursive = TRUE,showWarnings = FALSE)
    rmarkdown::render(rmd, output_dir = path_out,
           intermediates_dir="~/tmp")
    fn <- file_path_sans_ext(basename(rmd))
    print(paste0("https://dl.dropboxusercontent.com/u/20050186/hsph/",dn,"/",fn,".html"))
}


runAllChunks <- function(rmd, envir=globalenv()){
    tempR <- tempfile(tmpdir = ".", fileext = ".R")
    on.exit(unlink(tempR))
    knitr::purl(rmd, output=tempR)
    sys.source(tempR, envir=envir)
}

get_report_links = function(fn_names, path="/home/lpantano/repos/pipelines"){
    sapply(fn_names, function(fn){
        fn = normalizePath(fn)
        sub(path,"http://github.com/lpantano/scripts_hsph/raw/reports",fn)
    })
}


get_report_html = function(fn_names, path="/home/lpantano/repos/pipelines"){
    sapply(fn_names, function(fn){
        sub(path,"http://rawgit.com/lpantano/scripts_hsph/reports",fn)
    })
}


copy_2_drop <- function(figure, dn){
    path_out <- paste0("~/Dropbox/Public/hsph/",dn)
    file.copy(figure, path_out)
}

copy_batch_2_drop <- function(pattern, dn){
    path_out <- paste0("~/Dropbox/Public/hsph/",dn)
    flist <- list.files(".", pattern, full.names = TRUE)
    file.copy(flist, path_out)
}


save_file <- function(dat, fn){
    tab <- cbind(id=data.frame(id=row.names(dat)), as.data.frame(dat))
    write.table(tab, fn, quote=F, sep="\t", row.names=F)
}
