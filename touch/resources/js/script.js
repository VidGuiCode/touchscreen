// Touch interactions and AJAX polling
let isDown = false;
let startY;
let scrollTop;
const wrapper = document.querySelector('.scroll-wrapper');
if(wrapper){
    wrapper.addEventListener('mousedown', (e)=>{
        isDown = true;
        startY = e.pageY - wrapper.offsetTop;
        scrollTop = wrapper.scrollTop;
    });
    wrapper.addEventListener('mouseleave', ()=>{ isDown = false; });
    wrapper.addEventListener('mouseup', ()=>{ isDown = false; });
    wrapper.addEventListener('mousemove', (e)=>{
        if(!isDown) return;
        e.preventDefault();
        const y = e.pageY - wrapper.offsetTop;
        const walk = (y - startY);
        wrapper.scrollTop = scrollTop - walk;
    });
}
function showLoading(){
    const bar = document.getElementById('progress-bar');
    bar.style.width='0%';
    document.getElementById('loading').style.display='flex';
    let w = 0;
    window.loadingInterval = setInterval(()=>{
        w = (w+10)%100;
        bar.style.width=w+'%';
    },500);
}
function hideLoading(){
    clearInterval(window.loadingInterval);
    document.getElementById('loading').style.display='none';
}
function updateStatistics(){
    fetch('resources/fetch/fetch_statistics.php').then(r=>r.json()).then(data=>{
        document.getElementById('stat-nodes').textContent = data.nodes;
    });
}
function updateNodes(){
    fetch('resources/fetch/fetch_nodes.php').then(r=>r.json()).then(data=>{
        const container = document.getElementById('nodes');
        container.innerHTML='';
        data.forEach(n=>{
            const card = document.createElement('div');
            card.className='card';
            card.innerHTML = `<strong>${n.name||'Unnamed'}</strong><br><span class="${n.online?'status-online':'status-offline'}">${n.online?'Online':'Offline'}</span>`;
            card.addEventListener('click', ()=>{ location.href='node.php?id='+n.pk; });
            container.appendChild(card);
        });
    });
}
function fetchNodeData(){
    const id = document.body.dataset.node;
    if(!id) return;
    fetch('resources/fetch/fetch_node_data.php?id='+id).then(r=>r.json()).then(data=>{
        document.getElementById('node-name').textContent = data.node.name;
        document.getElementById('node-soil').textContent = data.latest.soilMoisture ?? 'N/A';
        if(window.chart){
            chart.updateSeries([{data:data.chart.soil}]);
        } else {
            chart = new ApexCharts(document.querySelector('#chart'), {
                chart: { type:'line', height:200 },
                series: [{ name:'Soil', data:data.chart.soil }],
                xaxis: { type:'datetime' }
            });
            chart.render();
        }
    });
}
setInterval(updateStatistics,5000);
setInterval(updateNodes,5000);
setInterval(fetchNodeData,30000);
document.addEventListener('DOMContentLoaded',()=>{
    hideLoading();
    updateStatistics();
    updateNodes();
    fetchNodeData();
});
