xmas2013
========

Code I used to generate my wife's 2013 XMas gift


### What it does
Takes a user's instagram photos, and generates a set of 4x6 images that can be printed out at Target/CVS/Walmart/etc and put together to make a collage like so: ![Imgur](http://i.imgur.com/0pLaIK1.jpg)


### How it does it
1. Downloads all the pictures from a person's instagram account
2. Throws out a few pictures (I didn't want to include a handful of pictures in the gift I made)
3. Resizes all pictures to 612x612 squares
4. Uses the metadata for each photo to generate a block of text above or below which contains:
    1. The caption posted along with the photo
    2. The number of months that elapsed between a pre-defined reference date and the time the photo was posted
    3. The hashtags that were extracted from the caption
5. Joins the photo with the caption block described above to make a 2x3 image
6. Joins sets of 4 images together to make a 4x6 image with four photos put together


### How to run it
```
INSTAUSER=<instagram-username-here> REFDATE=<date-in-"YYYY-MM-DD"-format-here> sh master_script.sh
```


### Disclaimers
The code I've written is very specific to the project I was working on, so you'll probably need to make some adjustments to the code to make it work the way you'd like.  Still, it at least gives an outline of how to make a photo collage from instagram photos.

I also ended up stripping out two very specific emoji from the captions because they weren't playing nicely with ImageMagick.  Watch out for those emoji!


### Software employed in this project (a.k.a. works for me under these conditions)
- Mac OS X Mavericks
- Ruby 2.0
- bundler 1.5.1
- ImageMagick 6.8.7-7
- My fork of [downstagram](https://github.com/aguynamedryan/downstagram)
    - Setting up downstagram is beyond the scope of this readme


# License
MIT, but it would be nice if you shot me a message letting me know how your own project turned out if you end up using this code.
