
CREATE TABLE stocks (
    stock_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stock_symbol TEXT NOT NULL,
    company_name TEXT NOT NULL,
    sector TEXT NOT NULL
);

CREATE TABLE stock_prices (
    price_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stock_id INTEGER NOT NULL,
    date TEXT NOT NULL,
    open_price REAL NOT NULL,
    close_price REAL NOT NULL,
    volume INTEGER NOT NULL,
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

CREATE TABLE market_conditions (
    condition_id INTEGER PRIMARY KEY AUTOINCREMENT,
    condition_name TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL
);

INSERT INTO stocks (stock_symbol, company_name, sector) VALUES
('TCS', 'Tata Consultancy Services', 'Information Technology'),
('INFY', 'Infosys', 'Information Technology'),
('HDFCBANK', 'HDFC Bank', 'Finance'),
('ICICIBANK', 'ICICI Bank', 'Finance'),
('RELIANCE', 'Reliance Industries', 'Energy'),
('ONGC', 'Oil and Natural Gas Corporation', 'Energy'),
('HINDUNILVR', 'Hindustan Unilever', 'Consumer Goods'),
('ITC', 'ITC Limited', 'Consumer Goods'),
('SUNPHARMA', 'Sun Pharmaceutical', 'Healthcare'),
('DRREDDY', 'Dr. Reddy\'s Laboratories', 'Healthcare');

-- Insert data into `stock_prices`
INSERT INTO stock_prices (stock_id, date, open_price, close_price, volume) VALUES
(1, '2023-01-02', 3500.00, 3550.00, 1000000),
(2, '2023-01-02', 1450.00, 1480.00, 500000),
(3, '2023-01-02', 1600.00, 1620.00, 2000000),
(4, '2023-01-02', 700.00, 715.00, 1500000),
(5, '2023-01-02', 2200.00, 2250.00, 1200000),
(6, '2023-01-02', 140.00, 145.00, 800000),
(7, '2023-01-02', 2500.00, 2530.00, 1100000),
(8, '2023-01-02', 350.00, 355.00, 900000),
(9, '2023-01-02', 500.00, 505.00, 700000),
(10, '2023-01-02', 4500.00, 4550.00, 1300000);


SELECT
    s.sector,
    AVG((sp.close_price - sp.open_price) / sp.open_price * 100) AS average_return
FROM
    stock_prices sp
JOIN
    stocks s ON sp.stock_id = s.stock_id
GROUP BY
    s.sector;

SELECT
    s.sector,
    SQRT(AVG((sp.return - subquery.avg_return) * (sp.return - subquery.avg_return))) AS volatility
FROM
    (SELECT
        stock_id,
        (close_price - open_price) / open_price * 100 AS return
    FROM stock_prices) sp
JOIN
    stocks s ON sp.stock_id = s.stock_id
JOIN
    (SELECT
        s.sector,
        AVG((sp.close_price - sp.open_price) / sp.open_price * 100) AS avg_return
    FROM
        stock_prices sp
    JOIN
        stocks s ON sp.stock_id = s.stock_id
    GROUP BY
        s.sector) subquery
    ON s.sector = subquery.sector
GROUP BY
    s.sector;

