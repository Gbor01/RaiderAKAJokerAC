var element = new Image;

element.__defineGetter__("id", function () {
    fetch("http://JokerAC/devtoolOpening", { //JokerAC helyére az anticheat nevét
        method: "post"
    })
});
console.log(element);
