# This script runs the entire process from downloading the images to generating the final set of pictures
downstagram -m ${INSTAUSER}
bundle exec ruby rename_files.rb
bundle exec ruby scrub_files.rb
sh resize_files.sh
bundle exec ruby make_appends.rb
