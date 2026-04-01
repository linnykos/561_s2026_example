.demo_tibble <- function(){
  data <- data.frame(a = 1:3,
                     b = letters[1:3],
                     c = Sys.Date())
  data <- tibble::as_tibble(data)
  tmp <- data %>% dplyr::filter(a == 1)

  return(tmp)
}
