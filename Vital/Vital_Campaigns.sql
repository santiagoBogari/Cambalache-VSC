/*  */

SELECT 
Camp.Id AS Campaign_ID,
Camp.ParentId AS Campaign_ParentID,
CampMem.Id AS C_MemberID,
Camp.Name AS Campaign_Name,
Camp.Type AS Campaign_Type,
Camp.Status AS Campaign_Status,
Camp.StartDate AS Campaign_StartDate,
Camp.EndDate AS Campaign_EndDate,
Camp.IsActive AS Campaign_IsActive,
CampMem.LeadId AS C_Member_LeadID,
CampMem.ContactId AS C_Member_ContactID,
CampMem.Status AS C_Member_Status,
CampMem.HasResponded AS C_Member_HasResponded,
CampMem.Name AS C_Member_Name,
CampMem.FirstName AS C_Member_FirstName,
CampMem.LastName AS C_Member_LastName,
CampMem.LeadSource AS C_Member_LeadSource,
CampMem.Type AS C_Member_Type
FROM SFImport_Campaign AS Camp
LEFT JOIN SFImport_CampaignMember AS CampMem ON Camp.Id = CampMem.CampaignId
WHERE CampMem.Id IS NOT NULL

/*  */
Campaign ID
Campaign Parent ID
Campaing Member ID
Campaign Name
Campaign Tipe
Campaign Status
Campaign Start Date
Campaign End Date
Campaign Is Active
Camp Member Lead ID
Camp Member Contact ID
Camp Member Status
Camp Member Has Responded
Camp Member Name
Camp Member First Name
Camp Member Last Name
Camp Member Lead Source
Camp Member Type