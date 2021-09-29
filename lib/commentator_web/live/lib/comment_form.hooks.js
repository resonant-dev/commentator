let CommentForm = {
  mounted() {
    this.handleEvent("submitted", () => {
      let textArea = document.getElementById("text");
      textArea.value = "";
      textArea.blur();
    });
  },
};

export { CommentForm };
