#' Validate Input Column
#'
#' Validates the input column exists in the dataframe, is of the correct type,
#' and that all values are greater than or equal to 0.
#'
#' @param column_name String value of the column name
#' @param input_df Dataframe containing option_name (str) and various other columns
#'     depending on the distribution type. See vignette for more details.
#' @param greater_than_zero Boolean: Do all values in the column have to be greater than zero?
#'
#' @return None
#'
#' @importFrom purrr some
#'
validate_input_column <- function(column_name, input_df, greater_than_zero = TRUE){
  # Ensure All Columns Exist
  if(!column_name %in% colnames(input_df)){
    stop(paste(column_name, "is a required column for this distribution type and is not found in the input_df."))
  }

  # Ensure Column Types are correct
  if(column_name == "option_name"){
    if(!is.character(input_df[["option_name"]])){
      stop("option_name column is not a character string")
    }
  }else{
    if(!is.numeric(input_df[[column_name]])){
      stop(paste(column_name, "is not a numeric column."))
    }
  }

  if(greater_than_zero){
    # Ensure all values are greater than or equal to 0.
    if(purrr::some(input_df[[column_name]], ~ .x < 0)){
      stop(paste("All values in column `",
                 column_name,
                 "` must be greater than or equal to zero."))
    }
  }
}
