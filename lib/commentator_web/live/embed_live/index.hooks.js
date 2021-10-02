import { isInViewport } from "../utils";

let EmbedLive = {
  mounted() {
    console.log(document.referrer);
    this.handleEvent("post_submit", () => {
      // Scroll ONLY if the user is at the bottom of the list.
      const commentList = document.getElementById("comment-list");
      if (isInViewport(commentList.lastElementChild)) {
        window.scrollBy(0, commentList.lastElementChild.offsetHeight);
      }
    });
  },
};

export { EmbedLive };
