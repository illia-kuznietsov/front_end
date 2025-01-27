let Hooks = {};

Hooks.DaySelection = {
    mounted() {
      this.handleEvent("update_selection", ({ current_id, new_id }) => {
        const currentElement = document.getElementById(current_id);
        const newElement = document.getElementById(new_id);
  
        if (currentElement) {
          currentElement.classList.remove("bg-selected", "dark:bg-selected-dark", "text-white");
          currentElement.classList.add("dark:text-secondary-dark");
        }
  
        if (newElement) {
          newElement.classList.remove("dark:text-secondary-dark");
          newElement.classList.add("bg-selected", "dark:bg-selected-dark", "text-white");
        }
      });
    },
  };
  

export default Hooks;