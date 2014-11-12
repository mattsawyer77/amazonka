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

-- Module      : Network.AWS.CloudFront.GetCloudFrontOriginAccessIdentityConfig
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Get the configuration information about an origin access identity.
module Network.AWS.CloudFront.GetCloudFrontOriginAccessIdentityConfig
    (
    -- * Request
      GetCloudFrontOriginAccessIdentityConfig
    -- ** Request constructor
    , getCloudFrontOriginAccessIdentityConfig2014_05_31
    -- ** Request lenses
    , gcfoaicId

    -- * Response
    , GetCloudFrontOriginAccessIdentityConfigResult
    -- ** Response constructor
    , getCloudFrontOriginAccessIdentityConfig2014_05_31Response
    -- ** Response lenses
    , gcfoaicrCloudFrontOriginAccessIdentityConfig
    , gcfoaicrETag
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.CloudFront.Types

newtype GetCloudFrontOriginAccessIdentityConfig = GetCloudFrontOriginAccessIdentityConfig
    { _gcfoaicId :: Text
    } deriving (Eq, Ord, Show, Generic, Monoid, IsString)

-- | 'GetCloudFrontOriginAccessIdentityConfig' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gcfoaicId' @::@ 'Text'
--
getCloudFrontOriginAccessIdentityConfig2014_05_31 :: Text -- ^ 'gcfoaicId'
                                                  -> GetCloudFrontOriginAccessIdentityConfig
getCloudFrontOriginAccessIdentityConfig2014_05_31 p1 = GetCloudFrontOriginAccessIdentityConfig
    { _gcfoaicId = p1
    }

-- | The identity's id.
gcfoaicId :: Lens' GetCloudFrontOriginAccessIdentityConfig Text
gcfoaicId = lens _gcfoaicId (\s a -> s { _gcfoaicId = a })

instance ToPath GetCloudFrontOriginAccessIdentityConfig where
    toPath GetCloudFrontOriginAccessIdentityConfig{..} = mconcat
        [ "/2014-05-31/origin-access-identity/cloudfront/"
        , toText _gcfoaicId
        , "/config"
        ]

instance ToQuery GetCloudFrontOriginAccessIdentityConfig where
    toQuery = const mempty

instance ToHeaders GetCloudFrontOriginAccessIdentityConfig

data GetCloudFrontOriginAccessIdentityConfigResult = GetCloudFrontOriginAccessIdentityConfigResult
    { _gcfoaicrCloudFrontOriginAccessIdentityConfig :: Maybe CloudFrontOriginAccessIdentityConfig
    , _gcfoaicrETag                                 :: Maybe Text
    } deriving (Eq, Show, Generic)

-- | 'GetCloudFrontOriginAccessIdentityConfigResult' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gcfoaicrCloudFrontOriginAccessIdentityConfig' @::@ 'Maybe' 'CloudFrontOriginAccessIdentityConfig'
--
-- * 'gcfoaicrETag' @::@ 'Maybe' 'Text'
--
getCloudFrontOriginAccessIdentityConfig2014_05_31Response :: GetCloudFrontOriginAccessIdentityConfigResult
getCloudFrontOriginAccessIdentityConfig2014_05_31Response = GetCloudFrontOriginAccessIdentityConfigResult
    { _gcfoaicrCloudFrontOriginAccessIdentityConfig = Nothing
    , _gcfoaicrETag                                 = Nothing
    }

-- | The origin access identity's configuration information.
gcfoaicrCloudFrontOriginAccessIdentityConfig :: Lens' GetCloudFrontOriginAccessIdentityConfigResult (Maybe CloudFrontOriginAccessIdentityConfig)
gcfoaicrCloudFrontOriginAccessIdentityConfig =
    lens _gcfoaicrCloudFrontOriginAccessIdentityConfig
        (\s a -> s { _gcfoaicrCloudFrontOriginAccessIdentityConfig = a })

-- | The current version of the configuration. For example: E2QWRUHAPOMQZL.
gcfoaicrETag :: Lens' GetCloudFrontOriginAccessIdentityConfigResult (Maybe Text)
gcfoaicrETag = lens _gcfoaicrETag (\s a -> s { _gcfoaicrETag = a })

instance FromXML GetCloudFrontOriginAccessIdentityConfigResult where
    fromXMLOptions = xmlOptions
    fromXMLRoot    = fromRoot "GetCloudFrontOriginAccessIdentityConfigResult"
instance AWSRequest GetCloudFrontOriginAccessIdentityConfig where
    type Sv GetCloudFrontOriginAccessIdentityConfig = CloudFront
    type Rs GetCloudFrontOriginAccessIdentityConfig = GetCloudFrontOriginAccessIdentityConfigResult

    request  = get
    response = xmlResponse $ \h x -> GetCloudFrontOriginAccessIdentityConfigResult
        <$> x %| "CloudFrontOriginAccessIdentityConfig"
        <*> h ~:? "ETag"
