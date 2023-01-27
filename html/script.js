$(function() {

    function display(bool) {
        if (bool) {
            $("html").show();
        } else {
            $("html").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                clothing_label = item.clothing_label;
                tower_label = item.tower_label;
                jobs_label = item.jobs_label;
                gasoline_label = item.gasoline_label;
                legaljob_label = item.legaljob_label;
                market_label = item.market_label;
                mechanic_label = item.mechanic_label;
                bank_label = item.bank_label;
                garage_label = item.garage_label;



                
                document.getElementById("tower_labell").innerHTML='<p>'+tower_label+'</p>';
                document.getElementById("jobs_labell").innerHTML='<p>'+jobs_label+'</p>';
                document.getElementById("gasoline_labell").innerHTML='<p>'+gasoline_label+'</p>';
                document.getElementById("legaljob_labell").innerHTML='<p>'+legaljob_label+'</p>';
                document.getElementById("market_labell").innerHTML='<p>'+market_label+'</p>';
                document.getElementById("mechanic_labell").innerHTML='<p>'+mechanic_label+'</p>';
                document.getElementById("bank_labell").innerHTML='<p>'+bank_label+'</p>';
                document.getElementById("clothing_labell").innerHTML='<p>'+clothing_label+'</p>';
                document.getElementById("garage_labell").innerHTML='<p>'+garage_label+'</p>';


                const checkbox_clothing = document.getElementById("check_box_clothing");
                checkbox_clothing.addEventListener("change", function() {
                  if (this.checked) {
                        sendIt("clothing",true);
                  } else {
                    sendIt("clothing",false);
                  }
                });

                const checkbox_tower = document.getElementById("check_box_tower");
                checkbox_tower.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("tower",true);
                  } else {
                    sendIt("tower",false);
                  }
                });

                const checkbox_job = document.getElementById("check_box_job");
                checkbox_job.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("jobs",true);
                  } else {
                    sendIt("jobs",false);
                  }
                });

                const checkbox_gasoline = document.getElementById("check_box_gasoline");
                checkbox_gasoline.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("gasoline",true);
                  } else {
                    sendIt("gasoline",false);
                  }
                });

                const checkbox_legaljob = document.getElementById("check_box_legaljob");
                checkbox_legaljob.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("legal_jobs",true);
                  } else {
                    sendIt("legal_jobs",false);
                  }
                });

                const checkbox_market = document.getElementById("check_box_market");
                checkbox_market.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("market",true);
                  } else {
                    sendIt("market",false);
                  }
                });

                const checkbox_mechanic = document.getElementById("check_box_mechanic");
                checkbox_mechanic.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("mechanic",true);
                  } else {
                    sendIt("mechanic",false);
                  }
                });

                const checkbox_bank = document.getElementById("check_box_bank");
                checkbox_bank.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("bank",true);
                  } else {
                    sendIt("bank",false);
                  }
                });

                const checkbox_garages = document.getElementById("check_box_garages");
                checkbox_garages.addEventListener("change", function() {
                  if (this.checked) {
                    sendIt("garage",true);
                  } else {
                    sendIt("garage",false);
                  }
                });






                display(true)
            } else {
                display(false)
            }
            document.onkeyup = function(data) {
                if (data.which == 27) {
                    $.post('http://zm_blips/exit', JSON.stringify({}));
                    return
                }
            };


        }
    })
})


function sendIt(param1,param2){
    $.post('https://zm_blips/blip_open_close', JSON.stringify({name: param1,status: param2}));
}

