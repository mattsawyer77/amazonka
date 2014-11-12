{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}
-- {-# OPTIONS_GHC -fno-warn-unused-binds  #-} doesnt work if wall is used
{-# OPTIONS_GHC -w #-}

-- Module      : Network.AWS.ElastiCache.CreateSnapshot
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | The CreateSnapshot operation creates a copy of an entire cache cluster at a
-- specific moment in time.
module Network.AWS.ElastiCache.CreateSnapshot
    (
    -- * Request
      CreateSnapshotMessage
    -- ** Request constructor
    , createSnapshot
    -- ** Request lenses
    , csmCacheClusterId
    , csmSnapshotName

    -- * Response
    , CreateSnapshotResult
    -- ** Response constructor
    , createSnapshotResponse
    -- ** Response lenses
    , csr1Snapshot
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.ElastiCache.Types

data CreateSnapshotMessage = CreateSnapshotMessage
    { _csmCacheClusterId :: Text
    , _csmSnapshotName   :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'CreateSnapshotMessage' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'csmCacheClusterId' @::@ 'Text'
--
-- * 'csmSnapshotName' @::@ 'Text'
--
createSnapshot :: Text -- ^ 'csmCacheClusterId'
               -> Text -- ^ 'csmSnapshotName'
               -> CreateSnapshotMessage
createSnapshot p1 p2 = CreateSnapshotMessage
    { _csmCacheClusterId = p1
    , _csmSnapshotName   = p2
    }

-- | The identifier of an existing cache cluster. The snapshot will be created
-- from this cache cluster.
csmCacheClusterId :: Lens' CreateSnapshotMessage Text
csmCacheClusterId =
    lens _csmCacheClusterId (\s a -> s { _csmCacheClusterId = a })

-- | A name for the snapshot being created.
csmSnapshotName :: Lens' CreateSnapshotMessage Text
csmSnapshotName = lens _csmSnapshotName (\s a -> s { _csmSnapshotName = a })

instance ToQuery CreateSnapshotMessage

instance ToPath CreateSnapshotMessage where
    toPath = const "/"

newtype CreateSnapshotResult = CreateSnapshotResult
    { _csr1Snapshot :: Maybe Snapshot
    } deriving (Eq, Show, Generic)

-- | 'CreateSnapshotResult' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'csr1Snapshot' @::@ 'Maybe' 'Snapshot'
--
createSnapshotResponse :: CreateSnapshotResult
createSnapshotResponse = CreateSnapshotResult
    { _csr1Snapshot = Nothing
    }

csr1Snapshot :: Lens' CreateSnapshotResult (Maybe Snapshot)
csr1Snapshot = lens _csr1Snapshot (\s a -> s { _csr1Snapshot = a })

instance FromXML CreateSnapshotResult where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "CreateSnapshotResult"

instance AWSRequest CreateSnapshotMessage where
    type Sv CreateSnapshotMessage = ElastiCache
    type Rs CreateSnapshotMessage = CreateSnapshotResult

    request  = post "CreateSnapshot"
    response = xmlResponse $ \h x -> CreateSnapshotResult
        <$> x %| "Snapshot"
