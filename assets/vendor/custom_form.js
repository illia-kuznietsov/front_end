document.addEventListener("DOMContentLoaded", () => {
    const button = document.getElementById("submitForm");
  
    if (button) {
      button.addEventListener("click", (event) => {
        console.log("button clicked!", event);
        const form = document.getElementById("customForm");
        const inputs = [];
        form.querySelectorAll('input').forEach(input=>{
            const {name, value} = input;
            inputs.push({name, value})
        }) 
        console.log(inputs)
      });
    }
  });