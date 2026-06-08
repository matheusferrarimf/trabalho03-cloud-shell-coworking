const form = document.getElementById('form-reserva');
const lista = document.getElementById('lista-reservas');
const totalReservas = document.getElementById('total-reservas');
const STORAGE_KEY = 'coworking_reservas';

function carregarReservas() {
    return JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
}

function salvarReservas(reservas) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(reservas));
}

function renderizarReservas() {
    const reservas = carregarReservas();
    lista.innerHTML = '';
    totalReservas.textContent = reservas.length;

    reservas.forEach((reserva) => {
        const linha = document.createElement('tr');
        linha.innerHTML = `
            <td>${reserva.membro}</td>
            <td>${reserva.sala}</td>
            <td>${reserva.data}</td>
            <td>${reserva.hora}</td>
        `;
        lista.appendChild(linha);
    });
}

form?.addEventListener('submit', (evento) => {
    evento.preventDefault();

    const reserva = {
        membro: document.getElementById('membro').value,
        sala: document.getElementById('sala').value,
        data: document.getElementById('data').value,
        hora: document.getElementById('hora').value
    };

    const reservas = carregarReservas();
    reservas.push(reserva);
    salvarReservas(reservas);
    form.reset();
    renderizarReservas();
});

renderizarReservas();
