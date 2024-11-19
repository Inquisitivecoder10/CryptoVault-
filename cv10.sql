CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

INSERT INTO Users (email, username, password) VALUES
('john.doe@example.com', 'johndoe', 'password123'),
('jane.smith@example.com', 'janesmith', 'password456'),
('mike.jackson@example.com', 'mikejackson', 'password789'),
('emily.williams@example.com', 'emilywilliams', 'passwordABC'),
('chris.brown@example.com', 'chrisbrown', 'passwordDEF'),
('sarah.jones@example.com', 'sarahjones', 'passwordGHI'),
('kevin.white@example.com', 'kevinwhite', 'passwordJKL'),
('lisa.miller@example.com', 'lisamiller', 'passwordMNO'),
('david.clark@example.com', 'davidclark', 'passwordPQR'),
('amy.taylor@example.com', 'amytaylor', 'passwordSTU');

select * from Users;

CREATE TABLE Portfolio (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    portfolio_name VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Portfolio (portfolio_id, user_id, portfolio_name) VALUES
(1, 1, 'John Doe Portfolio'),
(2, 2, 'Jane Smith Portfolio'),
(3, 3, 'Mike Jackson Portfolio'),
(4, 4, 'Emily Williams Portfolio'),
(5, 5, 'Chris Brown Portfolio'),
(6, 6, 'Sarah Jones Portfolio'),
(7, 7, 'Kevin White Portfolio'),
(8, 8, 'Lisa Miller Portfolio'),
(9, 9, 'David Clark Portfolio'),
(10, 10, 'Amy Taylor Portfolio');

select * from Portfolio;

CREATE TABLE Cryptocurrencies (
    crypto_id VARCHAR(5) PRIMARY KEY,
    crypto_name VARCHAR(100),
    short_name VARCHAR(10)
);

INSERT INTO Cryptocurrencies (crypto_id, crypto_name, short_name) VALUES
('CV101', 'Bitcoin', 'BTC'),
('CV102', 'Ethereum', 'ETH'),
('CV103', 'Binance Coin', 'BNB'),
('CV104', 'Solana', 'SOL'),
('CV105', 'Cardano', 'ADA'),
('CV106', 'Ripple', 'XRP'),
('CV107', 'Polkadot', 'DOT'),
('CV108', 'Dogecoin', 'DOGE');

select * from Cryptocurrencies; 

CREATE TABLE Investments (
    investment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    crypto_id VARCHAR(5),
    amount_invested DECIMAL(20, 5),
    profit_loss DECIMAL(20, 5),
    current_price DECIMAL(20, 5),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (crypto_id) REFERENCES Cryptocurrencies(crypto_id)
);

INSERT INTO Investments (user_id, crypto_id, amount_invested, profit_loss, current_price) VALUES
(1, 'CV101', 1000000, 200000, 55000),
(1, 'CV102', 500000, 10000, 2000),
(2, 'CV101', 1500000, 300000, 55000),
(2, 'CV103', 7000000, 500000, 500),
(3, 'CV102', 2000000, 200000, 2000),
(3, 'CV104', 3000000, 500000, 180),
(4, 'CV103', 1200000, 150000, 500),
(4, 'CV105', 800000, 10000, 1),
(5, 'CV101', 500000, 50000, 55000),
(5, 'CV104', 1000000, 200000, 180),
(6, 'CV101', 2000000, 300000, 55000),
(6, 'CV102', 1500000, 100000, 2000),
(7, 'CV102', 800000, 12000, 2000),
(7, 'CV105', 4000000, 7000, 1),
(8, 'CV103', 100000, 5000, 500),
(8, 'CV106', 2000000, 100000, 1),
(9, 'CV104', 300000, 6500, 180),
(9, 'CV107', 5000000, 100000, 30),
(10, 'CV101', 7000000, 800000, 55000),
(10, 'CV108', 600000, 5000, 0.5);

select * from Investments;

CREATE TABLE Company_Profile (
    Symbol VARCHAR(10) PRIMARY KEY,
    MarketCap DECIMAL(18, 8),
    AssetNames VARCHAR(255),
    CompanyInvestment DECIMAL(18, 8)
);

INSERT INTO Company_Profile VALUES
('BEBNB', 1000000.00, 'Bitcoin, Ethereum, Binance', 50000.00),
('BTCETH', 800000.00, 'Bitcoin, Ethereum', 30000.00),
('BNBSOL', 500000.00, 'Binance, Solana', 25000.00),
('BTCBNB', 700000.00, 'Bitcoin, Binance', 40000.00),
('ETHBNB', 600000.00, 'Ethereum, Binance', 35000.00),
('BTCXRP', 550000.00, 'Bitcoin, Ripple', 30000.00);

select * from Company_Profile;

CREATE TABLE Watchlist1 (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    crypto_id VARCHAR(5),
    crypto_short_name VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (crypto_id) REFERENCES Cryptocurrencies(crypto_id)
);

INSERT INTO Watchlist1 (user_id, crypto_id, crypto_short_name) VALUES
(1, 'CV101', 'BTC'),
(1, 'CV102', 'ETH'),
(2, 'CV103', 'BNB'),
(3, 'CV101', 'BTC'),
(4, 'CV102', 'ETH'),
(5, 'CV101', 'BTC'),
(6, 'CV101', 'BTC'),
(7, 'CV103', 'BNB'),
(8, 'CV101', 'BTC'),
(9, 'CV102', 'ETH'),
(10, 'CV101', 'BTC');

select * from Watchlist1;

CREATE TABLE UserBalances1 (
    user_id INT PRIMARY KEY,
    balance DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO UserBalances1 (user_id, balance) VALUES
(1, 1000000.00),
(2, 2000000.00),
(3, 30000000.00),
(4, 4000000.00),
(5, 5000000.00),
(6, 6000000.00),
(7, 7000000.00),
(8, 8000000.00),
(9, 9000000.00),
(10, 10000000.00);

select * from UserBalances1;