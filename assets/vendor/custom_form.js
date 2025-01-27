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

document.addEventListener("DOMContentLoaded", () => {
  const phoneInput = document.querySelector('input[name="phone"]');

  if (phoneInput) {
    phoneInput.addEventListener("input", (e) => {
      const input = e.target;
      let value = input.value.replace(/\D/g, "");
      const length = value.length;

      if (length > 0 && length <= 3) {
        value = `(${value}`;
      } else if (length > 3 && length <= 6) {
        value = `(${value.slice(0, 3)}) ${value.slice(3)}`;
      } else if (length > 6) {
        value = `(${value.slice(0, 3)}) ${value.slice(3, 6)} - ${value.slice(6, 10)}`;
      }

      input.value = value;
    });
  }
});
