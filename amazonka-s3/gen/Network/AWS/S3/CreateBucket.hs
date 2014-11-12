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

-- Module      : Network.AWS.S3.CreateBucket
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Creates a new bucket.
module Network.AWS.S3.CreateBucket
    (
    -- * Request
      CreateBucket
    -- ** Request constructor
    , createBucket
    -- ** Request lenses
    , cbACL
    , cbBucket
    , cbCreateBucketConfiguration
    , cbGrantFullControl
    , cbGrantRead
    , cbGrantReadACP
    , cbGrantWrite
    , cbGrantWriteACP

    -- * Response
    , CreateBucketOutput
    -- ** Response constructor
    , createBucketResponse
    -- ** Response lenses
    , cboLocation
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.S3.Types

data CreateBucket = CreateBucket
    { _cbACL                       :: Maybe Text
    , _cbBucket                    :: Text
    , _cbCreateBucketConfiguration :: Maybe CreateBucketConfiguration
    , _cbGrantFullControl          :: Maybe Text
    , _cbGrantRead                 :: Maybe Text
    , _cbGrantReadACP              :: Maybe Text
    , _cbGrantWrite                :: Maybe Text
    , _cbGrantWriteACP             :: Maybe Text
    } deriving (Eq, Show, Generic)

-- | 'CreateBucket' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cbACL' @::@ 'Maybe' 'Text'
--
-- * 'cbBucket' @::@ 'Text'
--
-- * 'cbCreateBucketConfiguration' @::@ 'Maybe' 'CreateBucketConfiguration'
--
-- * 'cbGrantFullControl' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantRead' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantReadACP' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantWrite' @::@ 'Maybe' 'Text'
--
-- * 'cbGrantWriteACP' @::@ 'Maybe' 'Text'
--
createBucket :: Text -- ^ 'cbBucket'
             -> CreateBucket
createBucket p1 = CreateBucket
    { _cbBucket                    = p1
    , _cbACL                       = Nothing
    , _cbCreateBucketConfiguration = Nothing
    , _cbGrantFullControl          = Nothing
    , _cbGrantRead                 = Nothing
    , _cbGrantReadACP              = Nothing
    , _cbGrantWrite                = Nothing
    , _cbGrantWriteACP             = Nothing
    }

-- | The canned ACL to apply to the bucket.
cbACL :: Lens' CreateBucket (Maybe Text)
cbACL = lens _cbACL (\s a -> s { _cbACL = a })

cbBucket :: Lens' CreateBucket Text
cbBucket = lens _cbBucket (\s a -> s { _cbBucket = a })

cbCreateBucketConfiguration :: Lens' CreateBucket (Maybe CreateBucketConfiguration)
cbCreateBucketConfiguration =
    lens _cbCreateBucketConfiguration
        (\s a -> s { _cbCreateBucketConfiguration = a })

-- | Allows grantee the read, write, read ACP, and write ACP permissions on
-- the bucket.
cbGrantFullControl :: Lens' CreateBucket (Maybe Text)
cbGrantFullControl =
    lens _cbGrantFullControl (\s a -> s { _cbGrantFullControl = a })

-- | Allows grantee to list the objects in the bucket.
cbGrantRead :: Lens' CreateBucket (Maybe Text)
cbGrantRead = lens _cbGrantRead (\s a -> s { _cbGrantRead = a })

-- | Allows grantee to read the bucket ACL.
cbGrantReadACP :: Lens' CreateBucket (Maybe Text)
cbGrantReadACP = lens _cbGrantReadACP (\s a -> s { _cbGrantReadACP = a })

-- | Allows grantee to create, overwrite, and delete any object in the bucket.
cbGrantWrite :: Lens' CreateBucket (Maybe Text)
cbGrantWrite = lens _cbGrantWrite (\s a -> s { _cbGrantWrite = a })

-- | Allows grantee to write the ACL for the applicable bucket.
cbGrantWriteACP :: Lens' CreateBucket (Maybe Text)
cbGrantWriteACP = lens _cbGrantWriteACP (\s a -> s { _cbGrantWriteACP = a })

instance ToPath CreateBucket where
    toPath CreateBucket{..} = mconcat
        [ "/"
        , toText _cbBucket
        ]

instance ToQuery CreateBucket where
    toQuery = const mempty

instance ToHeaders CreateBucket where
    toHeaders CreateBucket{..} = mconcat
        [ "x-amz-acl"                =: _cbACL
        , "x-amz-grant-full-control" =: _cbGrantFullControl
        , "x-amz-grant-read"         =: _cbGrantRead
        , "x-amz-grant-read-acp"     =: _cbGrantReadACP
        , "x-amz-grant-write"        =: _cbGrantWrite
        , "x-amz-grant-write-acp"    =: _cbGrantWriteACP
        ]

instance ToBody CreateBucket where
    toBody = toBody . encodeXML . _cbCreateBucketConfiguration

newtype CreateBucketOutput = CreateBucketOutput
    { _cboLocation :: Maybe Text
    } deriving (Eq, Ord, Show, Generic, Monoid)

-- | 'CreateBucketOutput' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cboLocation' @::@ 'Maybe' 'Text'
--
createBucketResponse :: CreateBucketOutput
createBucketResponse = CreateBucketOutput
    { _cboLocation = Nothing
    }

cboLocation :: Lens' CreateBucketOutput (Maybe Text)
cboLocation = lens _cboLocation (\s a -> s { _cboLocation = a })

instance FromXML CreateBucketOutput where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "CreateBucketOutput"
instance AWSRequest CreateBucket where
    type Sv CreateBucket = S3
    type Rs CreateBucket = CreateBucketOutput

    request  = put
    response = xmlResponse $ \h x -> CreateBucketOutput
        <$> h ~:? "Location"
