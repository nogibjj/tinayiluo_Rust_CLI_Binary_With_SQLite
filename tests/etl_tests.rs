use tina_yi_sqlite::{extract, query, transform_load};

#[test]
fn test_extract() {
    let url =
        "https://github.com/fivethirtyeight/data/blob/master/airline-safety/airline-safety.csv?raw=true";
    let file_path = "data/airline-safety.csv";
    let directory = "data";

    extract(url, file_path, directory);

    assert!(std::fs::metadata(file_path).is_ok());
}

#[test]
fn test_transform_load() {
    let dataset = "data/airline-safety.csv";
    let result = transform_load(dataset);

    assert_eq!(result.unwrap(), "AirlineSafetyDB.db");
}

#[test]
fn test_query() {
    // Execute a SELECT query
    let select_query = "SELECT * FROM AirlineSafetyDB WHERE airline = 'Alaska Airlines';";
    let result = query(select_query);

    assert!(result.is_ok());
}
