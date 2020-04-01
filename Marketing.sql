


    CREATE SCHEMA DirectMarketing
    AUTHORIZATION dbo;
    GO





--> CREATE TABLE DirectMarketing.Competitors(
   
    CompetitorId INT NOT NULL,
    CompetitorName NVARCHAR(50) NOT NULL,    
    BrandValue VARCHAR(15) NOT NULL,
    Rating INT NULL,
    CompetitorLocation VARCHAR(50) NOT NULL,
    IsActive bit NOT NULL );
    GO

 
 

--> CREATE TABLE DirectMarketing.TVAdvertisements(
    AddId int NOT NULL,
    AddName VARCHAR(50) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    TVChannel VARCHAR(50) NOT NULL,
    Repeatition int NOT NULL,
    Duration VARCHAR(30) NOT NULL,
    Cost MONEY NOT NULL,
    ADSchedule VARCHAR(50) NOT NULL,
    Date DATETIMEOFFSET(7) NOT NULL,
    IsActive bit NOT NULL
    );
    GO
    



--> CREATE TABLE DirectMarketing.CampaignResponses(

    CampaignId int NOT NULL,
    CampaignName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    StartDate DATETIMEOFFSET(7) NOT NULL,
    EndDate DATETIMEOFFSET(7) NOT NULL,
    Responses int NOT NULL,    
    InterestedTenant VARCHAR(50) NOT NULL,
    ConfirmTenant VARCHAR(50) NOT NULL,
    IsActive bit NOT NULL,
    Invested MONEY NOT NULL,
    Profit MONEY NOT NULL,
    Lead VARCHAR(30) NOT NULL,
    ResponseProfit(Invested-Revenue) PERSISTED
    );
    GO