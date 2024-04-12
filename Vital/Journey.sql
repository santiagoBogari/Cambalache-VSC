SELECT TOP 3000
        _JourneyActivity.VersionID,
        _JourneyActivity.ActivityID,
        _JourneyActivity.ActivityName,
        _JourneyActivity.ActivityExternalKey,
        _JourneyActivity.JourneyActivityObjectID,
        _JourneyActivity.ActivityType,
        _Journey.JourneyID,
        _Journey.JourneyName,
        _Journey.VersionNumber,
        _Journey.CreatedDate AS JourneyCreatedDate,
        _Journey.LastPublishedDate,
        _Journey.ModifiedDate,
        _Journey.JourneyStatus
FROM _JourneyActivity
LEFT JOIN _Journey 
        ON _JourneyActivity.VersionID = _Journey.VersionID
WHERE _Journey.CreatedDate IS NOT NULL        
ORDER BY _Journey.CreatedDate ASC