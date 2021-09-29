const isInViewport = (element) => {
  const rect = element.getBoundingClientRect();
  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
    rect.right <= (window.innerWidth || document.documentElement.clientWidth)
  );
};

let CommentForm = {
  mounted() {
    this.handleEvent("submitted", ({ key_submit }) => {
      if (key_submit) {
        let textArea = document.getElementById("text");
        textArea.value = "";
        textArea.blur();
      }
      // const commentList = document.getElementById("comment-list");

      // setTimeout(() => {
      //   window.scrollBy(0, commentList.lastElementChild.offsetHeight);
      // }, 50);
    });
    this.handleEvent("post_submit", () => {
      // Scroll ONLY if the user is at the bottom of the list.
      const commentList = document.getElementById("comment-list");
      console.log("is in viewport", isInViewport(commentList.lastElementChild));
      if (isInViewport(commentList.lastElementChild)) {
        window.scrollBy(0, commentList.lastElementChild.offsetHeight);
      }
    });
  },
};

export { CommentForm };
