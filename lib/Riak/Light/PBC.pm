## no critic (RequireUseStrict, RequireUseWarnings)
package Riak::Light::PBC;
## use critic
##
## This file was generated by Google::ProtocolBuffers (0.08)
## on Tue Apr 30 13:54:14 2013
##      
use strict;
use warnings;
use Google::ProtocolBuffers;
{       
    unless (RpbDelReq->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbDelReq',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'bucket', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'rw', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'vclock', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'r', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'w', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'pr', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'pw', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'dw', 9, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbPutReq->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbPutReq',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'bucket', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'vclock', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'RpbContent', 
                    'content', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'w', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'dw', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'return_body', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'pw', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'if_not_modified', 9, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'if_none_match', 10, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'return_head', 11, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbGetReq->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbGetReq',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'bucket', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'r', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'pr', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'basic_quorum', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'notfound_ok', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'if_modified', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'head', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'deletedvclock', 9, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbErrorResp->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbErrorResp',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'errmsg', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'errcode', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbLink->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbLink',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'bucket', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'tag', 3, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbGetResp->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbGetResp',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'RpbContent', 
                    'content', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'vclock', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'unchanged', 3, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbContent->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbContent',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'value', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'content_type', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'charset', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'content_encoding', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'vtag', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'RpbLink', 
                    'links', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'last_mod', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'last_mod_usecs', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'RpbPair', 
                    'usermeta', 9, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'RpbPair', 
                    'indexes', 10, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'deleted', 11, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbPair->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbPair',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'value', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (RpbPutResp->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'RpbPutResp',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'RpbContent', 
                    'contents', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'vclock', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'key', 3, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

}
1;