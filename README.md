<p align="center"><a href="https://plainsightcollection.github.io"><img src="https://plainsightcollection.github.io/web/resources/svg/logo.svg" width="25%"/></a></p>

"The Plainsight Collection" attempts to continue the time honored tradition of wasting time with entertainment software at work. To fight the realities of "open plan" offices, censoring firewalls, and locked down desktops, "The Plainsight Collection" goes "undercover" taking on the most ubiquitous and invisible form possible: the ad.

Taking advantage of the same security holes corporations maintain so that they can inundate you with advertisements, games in the "The Plainsight Collection" are available as bookmarklets that should work on any website that serves unrestricted third-party advertisements... which is to say almost all of them.

### What the Hell is a Bookmarklet?

A bookmarklet is a URL that contains a short computer program instead of the address of a website. On all of the major desktop browsers you can use the normal bookmark managers to manager and launch these short programs. The short programs in "The Plainsight Collection" hijack the currently viewed page to insert a fake ad implementing a classic office time-waster. For install details on installing, see [Install a Bookmarklet](#install-a-bookmarklet).

### Hijack the Page? Why the Hell Do Pages Let You Do That?

A combination of greed and sloth. There is a simple mechanism that could prevent it called the `Content Security Policy`. Pages on the web *could* tell your browser to only run code from them when you are on their site. However, this would mean that the site owner would have to pay to serve you ads (rather than them coming from other services), would not be able to invade your privacy as much (because they wouldn't be able to correlate your data with other sites) and would have to take legal responsibility for the ad content (which is risky because advertisers often serve malware and viruses).

### Enough! What About the Games?

Right now we have versions of two favorites:

[WallBall](#wallball): An area capture action game.

[Flippy Fantasy](#flippy-fantasy): A "Light Out" style type puzzle game.

### WallBall

Just create a bookmark with this URL:

    javascript:t=document.title;document.title="Loading...";r=new XMLHttpRequest();r.onload=function(e){eval(e.currentTarget.responseText)};r.open("GET","https://plainsightcollection.github.io/web/wallball/ldr.js",true);r.send();undefined;

For install details on installing, see [Install a Bookmarklet](#install-a-bookmarklet).

### Flippy Fantasy

Just create a bookmark with this URL:

    javascript:t=document.title;document.title="Loading...";r=new XMLHttpRequest();r.onload=function(e){eval(e.currentTarget.responseText)};r.open("GET","https://plainsightcollection.github.io/web/flippy/ldr.js",true);r.send();undefined;

For install details on installing, see [Install a Bookmarklet](#install-a-bookmarklet). 

### Install a Bookmarklet

#### Firefox

1. Copy one of the URLs above. Make sure you get all of it, from "'javascript'" all the to the "'undefined;'".
2. If your 'Bookmarks Toolbar' isn't visible, you will need to show it. To do so: 
	1. Find the search field at the top of your browser. To the right of it, you will see a star button. To the right of that is a button that looks somewhat like a clipboard or bulleted list. This button is the bookmarks button. Click it to reveal a menu. 
	2. Towards the bottom of this menu you will see a submenu 'Bookmarks Toolbar' Highlight this entry to reveal yet another menu. 
	3. At the top of this newly revealed menu should be a 'View Bookmarks Toolbar' entry. 
	4. If 'View Bookmarks Toolbar' has a check next to it, you don't need to do anything. If it doesn't click 'View Bookmarks Toolbar' to make the 'Bookmarks Toolbar' appear.
3. Below the URL field should be the 'Bookmarks Toolbar' (see above). Right click an empty place on it to reveal a menu.
4. Select 'New Bookmark' from this menu. A 'New Bookmark' form will appear.
5. Give the game a memorable (but we suggest obfuscated) name via the 'Name' field. 
6. Copy the URL into the 'Location' field.
7. Click the 'Add' button.

### Playing The Games

### Credits

gfx by [kittyhawk](http://montrose.is/sketching) 

code by [tjay](https://twitter.com/gtrevorjay)

flag photo by [Steven L. Shepard,](https://www.flickr.com/photos/presidioofmonterey/7343032302/in/photolist-cbSXFd-V7m7oA-fG6DkE-Umb5NH-dks2UK-akaEiD-r42Wbz-dj6sHS-vuQzpq-UtNgRn-MWPRW6-GsYbKp-sC3xFn-DLcQ23-8d5na3-UgEqx7-6rfLLY-HKoLD4-MmcrXv-VbHChi-LnaqEg-zbAcz2-usLDNR-6CfqBZ-v8ancB-vp5BWJ-GPEvc3-woMe5v-vsQ5ei-toJSzW-MztCF7-wXWB9J-xCkcKb-sJiAVS-UAv9vj-tCZpHS-sJirzh-wY5Agz-UZ4FgT-UAvcKA-w7ayto-KpxkF4-xUX8q6-toJn6f-toHckU-UZ4G9K-RWcrtt-ybZBcf-JxJnAv-ouAFcX)

desert photo by [Gentry George](https://commons.wikimedia.org/wiki/File:A_scenic_view_of_lands_on_the_desert.jpg)

Trump photo by [Shealah Craighead](https://commons.wikimedia.org/wiki/File:Trump_at_King_Khalid_International_Airport.jpg)

Lake Tekapo photo by [Bernard Spragg](https://www.flickr.com/photos/volvob12b/10339185584/)

<p align="center"><a href="http://montrose.is/games"><img src="https://plainsightcollection.github.io/web/resources/svg/montrose.svg" width="25%"/></a></p>
