import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50">
        <Toaster position="top-right" />
        <Routes>
          <Route path="/" element={<div className="flex items-center justify-center h-screen"><h1 className="text-4xl font-bold text-gray-800">Bienvenue sur E-Learning Platform</h1></div>} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
