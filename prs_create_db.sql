-- create and select the database
DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;

CREATE TABLE user (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,				
	UserName 				VARCHAR(20)					 NOT NULL	  UNIQUE,
	Password				VARCHAR(10)					 NOT NULL,
	FirstName				VARCHAR(20)					 NOT NULL,
	LastName				VARCHAR(20)					 NOT NULL,
	Phone					VARCHAR(12)					 NOT NULL,
	Email					VARCHAR(75)					 NOT NULL,
	IsReviewer				TinyInt(1)					 NOT NULL,
	IsAdmin					TinyInt(1)					 NOT NULL,
	IsActive				TinyInt(1)					 NOT NULL,
	DateCreated				DATETIME					 NOT NULL,
	DateUpdated				DATETIME					 NOT NULL,
	UpdatedByUser			INT 						 NOT NULL
);

CREATE TABLE vendor (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,					
	Code					VARCHAR(10)					 NOT NULL	  UNIQUE,
	Name					VARCHAR(255)				 NOT NULL,
	Address					VARCHAR(255)				 NOT NULL,
	City					VARCHAR(255)				 NOT NULL,
	State					VARCHAR(2)					 NOT NULL,
	Zip						VARCHAR(5)					 NOT NULL,
	Phone					VARCHAR(12)					 NOT NULL,
	Email					VARCHAR(100)				 NOT NULL,
	IsPreApproved			TinyInt(1)					 NOT NULL,
	IsActive				TinyInt(1)					 NOT NULL,
	DateCreated				DATETIME					 NOT NULL,
	DateUpdated				DATETIME					 NOT NULL,
	UpdatedByUser			INT					 		 NOT NULL
);

CREATE TABLE product (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,					
	VendorID				INT					 		 NOT NULL,
	PartNumber				VARCHAR(50)					 NOT NULL,
	Name					VARCHAR(150)				 NOT NULL,
	Price					DECIMAL(10,2)				 NOT NULL,
	Unit					VARCHAR(255) 				 ,
	PhotoPath				VARCHAR(255) 				 ,
	IsActive				TinyInt(1)					 NOT NULL,
	DateCreated				DATETIME					 NOT NULL,
	DateUpdated				DATETIME					 NOT NULL,
	UpdatedByUser			INT					 		 NOT NULL,
	UNIQUE KEY `vendor_part` (`VendorID`,`PartNumber`),
	FOREIGN KEY (VendorID) REFERENCES vendor(ID)
);

CREATE TABLE purchaseRequest (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,					 
	UserID					INT					 		 NOT NULL,
	Description				VARCHAR(100)				 NOT NULL,
	Justification			VARCHAR(255)				 NOT NULL,
	DateNeeded				DATE					 	 NOT NULL,
	DeliveryMode			VARCHAR(25)					 NOT NULL,
	Status					VARCHAR(20)					 NOT NULL,
	Total					DECIMAL(10,2)				 NOT NULL,
	SubmittedDate			DATETIME 					 ,
	IsActive				TinyInt(1)					 NOT NULL,
	ReasonForRejection		VARCHAR(100)				 NOT NULL,
	DateCreated				DATETIME					 NOT NULL,
	DateUpdated				DATETIME					 NOT NULL,
	UpdatedByUser			INT					 		 NOT NULL,
	FOREIGN KEY (UserID) REFERENCES user(ID)
);

CREATE TABLE purchaseRequestLineItem (
	ID 			    		INT            		 		PRIMARY KEY  AUTO_INCREMENT,					
	PurchaseRequestID		INT						    NOT NULL,
	ProductID				INT					 		NOT NULL,
	Quantity				INT							NOT NULL,
	IsActive				TinyInt(1)				 	NOT NULL,
	DateCreated				DATETIME					NOT NULL,
	DateUpdated				DATETIME					NOT NULL,
	UpdatedByUser			INT					 		NOT NULL,
	UNIQUE KEY `req_pdt` (`PurchaseRequestID`,`ProductID`),
	FOREIGN KEY (PurchaseRequestID) REFERENCES purchaseRequest(ID)
);


INSERT INTO User VALUES
(1,'SampleUser', '1234', 'Sample', 'User', '234-234-5322','Sampleuser@gmail.com', 1, 1, 1, NOW(), NOW(),0);

INSERT INTO Vendor VALUES
(1,'BB-01', 'Amazon', '401 Vendor St.', 'Seattle', 'WA','45252','234-234-2344','Bezos@amazon.com', 1, 1, NOW(), NOW(), 1);

INSERT INTO Product VALUES
(1, 1,'3235','Tape', 5.50, NULL, NULL, 1, NOW(), NOW(), 1)
