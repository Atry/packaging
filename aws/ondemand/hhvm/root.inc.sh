# Copyright (c) 2017-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

log "Installing Composer..."
curl https://getcomposer.org/composer.phar > /usr/local/bin/composer
chmod a+x /usr/local/bin/composer
ok
