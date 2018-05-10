'use strict'
/**
 * Copyright (c) 2017-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

const AWS = require('aws-sdk');
exports.handler = (event, context, callback) => {
  const ec2 = new AWS.EC2();
  ec2.terminateInstances(
    { InstanceIds: event.instances },
    function(err, data) {
      if (err) {
        callback(err, data);
      }
      callback(null, event);
    }
  );
};
