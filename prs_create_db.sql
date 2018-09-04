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
	PhoneNumber				VARCHAR(12)					 NOT NULL,
	Email					VARCHAR(75)					 NOT NULL	  UNIQUE,
	IsReviewer				TinyInt(1)					 NOT NULL,
	IsAdmin					TinyInt(1)					 NOT NULL,
	IsActive				TinyInt(1)					 NOT NULL DEFAULT 1,
	DateCreated				DATETIME					 NOT NULL DEFAULT current_timestamp,
	DateUpdated				DATETIME					 NOT NULL DEFAULT current_timestamp on update current_timestamp,
	UpdatedByUser			INT 						 NOT NULL DEFAULT 1
);

CREATE TABLE vendor (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,					
	Code					VARCHAR(10)					 NOT NULL	  UNIQUE,
	Name					VARCHAR(255)				 NOT NULL,
	Address					VARCHAR(255)				 NOT NULL,
	City					VARCHAR(255)				 NOT NULL,
	State					VARCHAR(2)					 NOT NULL,
	Zip						VARCHAR(5)					 NOT NULL,
	PhoneNumber				VARCHAR(12)					 NOT NULL,
	Email					VARCHAR(100)				 NOT NULL	  UNIQUE,
	IsPreApproved			TinyInt(1)					 NOT NULL,
	IsActive				TinyInt(1)					 NOT NULL DEFAULT 1,
	DateCreated				DATETIME					 NOT NULL DEFAULT current_timestamp,
	DateUpdated				DATETIME					 NOT NULL DEFAULT current_timestamp on update current_timestamp,
	UpdatedByUser			INT					 		 NOT NULL DEFAULT 1
);

CREATE TABLE product (
	ID 		    			INT            				 PRIMARY KEY  AUTO_INCREMENT,					
	VendorID				INT					 		 NOT NULL,
	PartNumber				VARCHAR(50)					 NOT NULL,
	Name					VARCHAR(150)				 NOT NULL,
	Price					DECIMAL(10,2)				 NOT NULL,
	Unit					VARCHAR(255) 				 ,
	PhotoPath				VARCHAR(255) 				 ,
	IsActive				TinyInt(1)					 NOT NULL DEFAULT 1,
	DateCreated				DATETIME					 NOT NULL DEFAULT current_timestamp,
	DateUpdated				DATETIME					 NOT NULL DEFAULT current_timestamp on update current_timestamp,
	UpdatedByUser			INT 						 NOT NULL DEFAULT 1,
	UNIQUE KEY vendor_part (VendorID,PartNumber),
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
	ReasonForRejection		VARCHAR(100)				 NOT NULL,
	IsActive				TinyInt(1)					 NOT NULL DEFAULT 1,	
	DateCreated				DATETIME					 NOT NULL DEFAULT current_timestamp,
	DateUpdated				DATETIME					 NOT NULL DEFAULT current_timestamp on update current_timestamp,
	UpdatedByUser			INT 						 NOT NULL DEFAULT 1,
	FOREIGN KEY (UserID) REFERENCES user(ID)
);

CREATE TABLE purchaseRequestLineItem (
	ID 			    		INT            		 		PRIMARY KEY  AUTO_INCREMENT,					
	PurchaseRequestID		INT						    NOT NULL,
	ProductID				INT					 		NOT NULL,
	Quantity				INT							NOT NULL,
	IsActive				TinyInt(1)			 		NOT NULL DEFAULT 1,
	DateCreated				DATETIME					NOT NULL DEFAULT current_timestamp,
	DateUpdated				DATETIME				 	NOT NULL DEFAULT current_timestamp on update current_timestamp,
	UpdatedByUser			INT 					 	NOT NULL DEFAULT 1,
	UNIQUE KEY req_pdt (PurchaseRequestID,ProductID),
	FOREIGN KEY (PurchaseRequestID) REFERENCES purchaseRequest(ID),
	FOREIGN KEY (ProductID)	REFERENCES Product(ID)
);


