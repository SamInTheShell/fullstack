import '@/App.css'
import { Routes, Route, BrowserRouter } from "react-router-dom";
import NotFoundPage from '@/components/pages/404';
import TodoPage from '@/components/pages/todo';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<TodoPage />} />

        {/* Catch-all 404 Route - MUST REMAIN AT BOTTOM */}
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
}
