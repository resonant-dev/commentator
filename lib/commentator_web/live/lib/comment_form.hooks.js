let CommentForm = {
  mounted() {
    this.handleEvent("submitted", ({ key_submit }) => {
      if (key_submit) {
        let textArea = document.getElementById("text");
        textArea.value = "";
        textArea.blur();
      }
    });
  },
};

export { CommentForm };
