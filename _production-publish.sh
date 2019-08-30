#!/bin/bash

# delete the gh-pages branch and then recreate it as an orphan (untracked) branch
git branch -D gh-pages
git checkout --orphan gh-pages

# move into the _src directory and compile source files
cd _src
# build a production-optimized webpack bundle
yarn run build
# exclude node dependencies from harp compilation
mv node_modules _node_modules
# compile source files to root directory
harp compile ./ ../
# restore node_modules before you forget
mv _node_modules node_modules

# move back to the root, and add and commit files
cd ../
git add -A
git commit -m "deploy"

# push changes to remote gh-pages branch using *gasp* --force!
# !!! Never push --force on any public branch besides gh-pages!
git push --set-upstream origin gh-pages --force

echo "http://openbudgetoakland.org updated"
