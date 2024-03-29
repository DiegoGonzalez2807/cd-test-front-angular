#  Copyright 2020 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Angular app image
FROM node:16.14.0-alpine as frontend
WORKDIR /usr/src/app
COPY package.json .
RUN npm install 
COPY . .
RUN npm install -g @angular/cli@13.1.1
RUN npm run build

# Angular app server
FROM nginx:1.20.2
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend /usr/src/app/dist/frontend /usr/share/nginx/html

